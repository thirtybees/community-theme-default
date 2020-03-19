{if !isset($addresses_style)}
  {$addresses_style.company = 'address_company'}
  {$addresses_style.vat_number = 'address_company'}
  {$addresses_style.firstname = 'address_name'}
  {$addresses_style.lastname = 'address_name'}
  {$addresses_style.address1 = 'address_address1'}
  {$addresses_style.address2 = 'address_address2'}
  {$addresses_style.city = 'address_city'}
  {$addresses_style.country = 'address_country'}
  {$addresses_style.phone = 'address_phone'}
  {$addresses_style.phone_mobile = 'address_phone_mobile'}
  {$addresses_style.alias = 'address_title'}
{/if}
{assign var='have_non_virtual_products' value=false}
{foreach $products as $product}
  {if $product.is_virtual == 0}
    {assign var='have_non_virtual_products' value=true}
    {break}
  {/if}
{/foreach}

{addJsDefL name=txtProduct}{l s='Product' js=1}{/addJsDefL}
{addJsDefL name=txtProducts}{l s='Products' js=1}{/addJsDefL}
{capture name=path}{l s='Your shopping cart'}{/capture}

{if $productNumber == 0}
  <div class="alert alert-warning">{l s='Your shopping cart is empty.'}</div>
{elseif $PS_CATALOG_MODE}
  <div class="alert alert-warning">{l s='This store has not accepted your new order.'}</div>
{else}
  <div id="emptyCartWarning" class="alert alert-warning unvisible">{l s='Your shopping cart is empty.'}</div>
  <h2>{l s='Payment Options'}</h2>

  <div id="HOOK_ADVANCED_PAYMENT">
    <div class="row">
      {* Should get a collection of "PaymentOption" object *}
      {assign var='adv_payment_empty' value=true}
      {foreach from=$HOOK_ADVANCED_PAYMENT item=pay_option key=key}
        {if $pay_option}
          {assign var='adv_payment_empty' value=false}
        {/if}
      {/foreach}
      {if $HOOK_ADVANCED_PAYMENT && !$adv_payment_empty}
      {foreach $HOOK_ADVANCED_PAYMENT as $advanced_payment_opt_list}
        {foreach $advanced_payment_opt_list as $paymentOption}
          <div class="col-xs-6 col-md-6">
            <p class="payment_module pointer-box">
              <a class="payment_module_adv">
                <img class="payment_option_logo" src="{$paymentOption->getLogo()}" alt="">
                  <span class="payment_option_cta">
                    {$paymentOption->getCallToActionText()}
                  </span>
                  <span class="pull-right payment_option_selected">
                    <i class="icon icon-check"></i>
                  </span>
              </a>

            </p>
            <div class="payment_option_form">
              {if $paymentOption->getForm()}
                {$paymentOption->getForm()}
              {else}
                <form method="{if $paymentOption->getMethod()}{$paymentOption->getMethod()}{else}POST{/if}" action="{$paymentOption->getAction()}">
                  {if $paymentOption->getInputs()}
                    {foreach from=$paymentOption->getInputs() item=value key=name}
                      <input type="hidden" name="{$name}" value="{$value}">
                    {/foreach}
                  {/if}
                </form>
              {/if}
            </div>
          </div>
        {/foreach}
      {/foreach}
    </div>
    {else}
    <div class="col-xs-12 col-md-12">
      <div class="alert alert-warning ">{l s='Unable to find any available payment option for your cart. Please contact us if the problem persists'}</div>
    </div>
    {/if}
  </div>

  {if $opc}
    {include file="$tpl_dir./order-carrier-advanced.tpl"}
  {/if}

  {if $is_logged AND !$is_guest}
    <div class="row">
        {if $delivery->id}
            <div class="col-xs-12 col-sm-6"{if !$have_non_virtual_products} style="display: none;"{/if}>
                <ul id="delivery_address" class="address item box">
                    <li><h3 class="page-subheading">{l s='Delivery address'}&nbsp;<span class="address_alias">({$delivery->alias})</span></h3></li>
                    {if $delivery->company}<li class="address_company">{$delivery->company|escape:'html':'UTF-8'}</li>{/if}
                    <li class="address_name">{$delivery->firstname|escape:'html':'UTF-8'} {$delivery->lastname|escape:'html':'UTF-8'}</li>
                    <li class="address_address1">{$delivery->address1|escape:'html':'UTF-8'}</li>
                    {if $delivery->address2}<li class="address_address2">{$delivery->address2|escape:'html':'UTF-8'}</li>{/if}
                    <li class="address_city">{$delivery->postcode|escape:'html':'UTF-8'} {$delivery->city|escape:'html':'UTF-8'}</li>
                    <li class="address_country">{$delivery->country|escape:'html':'UTF-8'} {if $delivery->id_state }({$delivery_state->name|escape:'html':'UTF-8'}){/if}</li>
                </ul>
            </div>
        {/if}
        {if $invoice->id}
            <div class="col-xs-12 col-sm-6">
                <ul id="invoice_address" class="address alternate_item box">
                    <li><h3 class="page-subheading">{l s='Invoice address'}&nbsp;<span class="address_alias">({$invoice->alias})</span></h3></li>
                    {if $invoice->company}<li class="address_company">{$invoice->company|escape:'html':'UTF-8'}</li>{/if}
                    <li class="address_name">{$invoice->firstname|escape:'html':'UTF-8'} {$invoice->lastname|escape:'html':'UTF-8'}</li>
                    <li class="address_address1">{$invoice->address1|escape:'html':'UTF-8'}</li>
                    {if $invoice->address2}<li class="address_address2">{$invoice->address2|escape:'html':'UTF-8'}</li>{/if}
                    <li class="address_city">{$invoice->postcode|escape:'html':'UTF-8'} {$invoice->city|escape:'html':'UTF-8'}</li>
                    <li class="address_country">{$invoice->country|escape:'html':'UTF-8'} {if $invoice->id_state}({$invoice->name|escape:'html':'UTF-8'}){/if}</li>
                </ul>
            </div>
        {/if}
    </div>
  {elseif $opc}
    {include file="$tpl_dir./order-opc-new-account-advanced.tpl"}
  {/if}

  {if $conditions AND $cms_id}
    {if $override_tos_display }
      {$override_tos_display}
    {else}
      <div class="row">
        <div class="col-xs-12 col-md-12">
          <h2>{l s='Terms and Conditions'}</h2>
          <div class="box">
            <div class="checkbox">
              <label for="cgv">
                <input type="checkbox" name="cgv" id="cgv" value="1" {if $checkedTOS}checked="checked"{/if}>
                {l s='I agree to the terms of service and will adhere to them unconditionally.'}
              </label>
              <a href="{$link_conditions|escape:'html':'UTF-8'}" class="iframe" rel="nofollow">{l s='(Read the Terms of Service)'}</a>
            </div>
          </div>
        </div>
      </div>
    {/if}
  {/if}

  {include file="$tpl_dir./shopping-cart-advanced.tpl" cannotModify=1 noDeleteButton=1}
{/if}
