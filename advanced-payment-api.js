var PaymentOptionHandler = function () {
  this.selected_option = null;

  this.selectOption = function (elem) {
    if (typeof elem === 'undefined' || elem.hasClass('payment_selected')) {
      return;
    }
    if (this.selected_option !== null) {
      this.unselectOption();
    }
    this.selected_option = elem;
    this.selected_option.addClass('payment_selected');
    this.selected_option.children('a:first').children('.payment_option_selected:first').fadeIn();
  };

  this.unselectOption = function () {
    this.selected_option.children('a:first').children('.payment_option_selected:first').fadeOut();
    this.selected_option.removeClass('payment_selected');
  };

  /* Return array with all payment option information required */
  this.submitForm = function () {
    if (typeof this.selected_option !== 'undefined' && this.selected_option !== null && this.selected_option.hasClass('payment_selected')) {
      var formToSubmit = this.selected_option.next('.payment_option_form').children('form:first');
      if (typeof formToSubmit !== 'undefined') {
        formToSubmit.submit();
        return true;
      }
    }
    return false;
  };

  this.checkTOS = function () {
    return !!$('#cgv').prop('checked');
  };

  this.checkVirtualProductRevocation = function () {
    return !!$('#revocation_vp_terms_agreed').prop('checked');
  };
};

$(document).ready(function () {
  var handler = new PaymentOptionHandler();

  if (typeof $.prototype.fancybox !== 'undefined' && $.prototype.fancybox) {
    $('a.iframe').fancybox({
      type: 'iframe',
      width: 600,
      height: 600
    });
  }

  $('p.payment_module').on('click', function () {
    handler.selectOption($(this));
  });

  $('#confirmOrder').on('click', function (event) {
    /* Avoid any further action */
    event.preventDefault();
    event.stopPropagation();

    if (handler.checkTOS() === false) {
      PrestaShop.showError(window.aeuc_tos_err_str);
      return;
    }
    if (window.aeuc_has_virtual_products === true && handler.checkVirtualProductRevocation() === false) {
      PrestaShop.showError(window.aeuc_virt_prod_err_str);
      return;
    }
    if (handler.selected_option === null) {
      PrestaShop.showError(window.aeuc_no_pay_err_str);
      return;
    }
    if (handler.submitForm() === false) {
      PrestaShop.showError(window.aeuc_submit_err_str);
      return;
    }
  });
});
