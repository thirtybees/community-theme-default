{assign var='have_non_virtual_products' value=false}
{if $opc}
  {assign var="back_order_page" value="order-opc.php"}
{else}
  {assign var="back_order_page" value="order.php"}
{/if}
{foreach $products as $product}
  {if $product.is_virtual == 0}
    {assign var='have_non_virtual_products' value=true}
    {break}
  {/if}
{/foreach}
<h2>{l s='Address Details'}</h2>
{if ((!empty($delivery_option) AND (!isset($isVirtualCart) || !$isVirtualCart)) OR $delivery->id OR $invoice->id)}
  <div class="addresses clearfix">
    <div class="row">
      <div class="col-xs-12 col-sm-6">
        <div class="address_delivery select form-group selector1">
          <label for="id_address_delivery">{if $cart->isVirtualCart()}{l s='Choose a billing address:'}{else}{l s='Choose a delivery address:'}{/if}</label>
          <select name="id_address_delivery" id="id_address_delivery" class="address_select form-control">
            {foreach from=$addresses key=k item=address}
              <option value="{$address.id_address|intval}"{if $address.id_address == $cart->id_address_delivery} selected="selected"{/if}>
                {$address.alias|escape:'html':'UTF-8'}
              </option>
            {/foreach}
          </select><span class="waitimage"></span>
        </div>
        <p class="checkbox addressesAreEquals"{if $cart->isVirtualCart()} style="display:none;"{/if}>
          <input type="checkbox" name="same" id="addressesAreEquals" value="1"{if $cart->id_address_invoice == $cart->id_address_delivery || $addresses|@count == 1} checked="checked"{/if}>
          <label for="addressesAreEquals">{l s='Use the delivery address as the billing address.'}</label>
        </p>
      </div>
      <div class="col-xs-12 col-sm-6">
        <div id="address_invoice_form" class="select form-group selector1"{if $cart->id_address_invoice == $cart->id_address_delivery} style="display: none;"{/if}>
          {if $addresses|@count > 1}
            <label for="id_address_invoice" class="strong">{l s='Choose a billing address:'}</label>
            <select name="id_address_invoice" id="id_address_invoice" class="address_select form-control">
              {section loop=$addresses step=-1 name=address}
                <option value="{$addresses[address].id_address|intval}"{if $addresses[address].id_address == $cart->id_address_invoice && $cart->id_address_delivery != $cart->id_address_invoice} selected="selected"{/if}>
                  {$addresses[address].alias|escape:'html':'UTF-8'}
                </option>
              {/section}
            </select>
            <span class="waitimage"></span>
          {else}
            <a href="{$link->getPageLink('address', true, NULL, "back={$back_order_page}?step=1&select_address=1{if $back}&mod={$back}{/if}")|escape:'html':'UTF-8'}" title="{l s='Add'}" class="button button-small btn btn-default">
              <span>
                  {l s='Add a new address'}
                <i class="icon-chevron-right right"></i>
              </span>
            </a>
          {/if}
        </div>
      </div>
    </div> <!-- end row -->
    <div class="row">
      <div class="col-xs-12 col-sm-6"{if $cart->isVirtualCart()} style="display:none;"{/if}>
        <ul class="address item box" id="address_delivery">
        </ul>
      </div>
      <div class="col-xs-12 col-sm-6">
        <ul class="address alternate_item{if $cart->isVirtualCart()} full_width{/if} box" id="address_invoice">
        </ul>
      </div>
    </div> <!-- end row -->
    <p class="address_add submit">
      <a href="{$link->getPageLink('address', true, NULL, "back={$back_order_page}?step=1{if $back}&mod={$back}{/if}")|escape:'html':'UTF-8'}" title="{l s='Add'}" class="button button-small btn btn-default">
        <span>{l s='Add a new address'}<i class="icon-chevron-right right"></i></span>
      </a>
    </p>

  </div>
  <!-- end addresses -->
  {strip}
    {capture}{if $back}&mod={$back|urlencode}{/if}{/capture}
    {capture name=addressUrl}{$link->getPageLink('address', true, NULL, 'back='|cat:$back_order_page|cat:'?step=1'|cat:$smarty.capture.default)|escape:'quotes':'UTF-8'}{/capture}
    {addJsDef addressUrl=$smarty.capture.addressUrl}
    {capture}{'&multi-shipping=1'|urlencode}{/capture}
    {addJsDef addressMultishippingUrl=$smarty.capture.addressUrl|cat:$smarty.capture.default}
    {capture name=addressUrlAdd}{$smarty.capture.addressUrl|cat:'&id_address='}{/capture}
    {addJsDef addressUrlAdd=$smarty.capture.addressUrlAdd}
    {addJsDef formatedAddressFieldsValuesList=$formatedAddressFieldsValuesList}
    {addJsDef opc=$opc|boolval}
    {capture}<h3 class="page-subheading">{l s='Your billing address' js=1}</h3>{/capture}
    {addJsDefL name=titleInvoice}{$smarty.capture.default|@addcslashes:'\''}{/addJsDefL}
    {capture}<h3 class="page-subheading">{l s='Your delivery address' js=1}</h3>{/capture}
    {addJsDefL name=titleDelivery}{$smarty.capture.default|@addcslashes:'\''}{/addJsDefL}
    {capture}<a class="button button-small btn btn-default" href="{$smarty.capture.addressUrlAdd}" title="{l s='Update' js=1}"><span>{l s='Update' js=1}<i class="icon-chevron-right right"></i></span></a>{/capture}
    {addJsDefL name=liUpdate}{$smarty.capture.default|@addcslashes:'\''}{/addJsDefL}
  {/strip}
{/if}

