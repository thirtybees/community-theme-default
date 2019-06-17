{capture name=path}{l s='Suppliers:'}{/capture}

{assign var='mediumDefaultWidth' value={getWidthSize|intval type='medium_default'}}
{assign var='mediumDefaultHeight' value={getHeightSize|intval type='medium_default'}}
{if ImageManager::retinaSupport()}
  {assign var='mediumDefaultWidth' value=$mediumDefaultWidth * 2}
  {assign var='mediumDefaultHeight' value=$mediumDefaultHeight * 2}
{/if}


<div class="product-listing page-heading">
  <h1 class="pull-left product-listing-title">{l s='Suppliers:'}</h1>
  <div class="pull-right">
    <span class="heading-counter badge">
      {if $nbSuppliers == 0}{l s='There are no suppliers.'}
      {else}
        {if $nbSuppliers == 1}
          {l s='There is %d supplier.' sprintf=$nbSuppliers}
        {else}
          {l s='There are %d suppliers.' sprintf=$nbSuppliers}
        {/if}
      {/if}
    </span>
  </div>
</div>


{if !empty($errors)}
  {include file="$tpl_dir./errors.tpl"}
{else}

  {if $nbSuppliers > 0}
    <div class="content_sortPagiBar">
      <div class="form-inline sortPagiBar clearfix">

        {if isset($supplier) && isset($supplier.nb_products) && $supplier.nb_products > 0}
          {include file='./product-list-switcher.tpl'}
        {/if}

        {include file="./nbr-product-page.tpl"}
      </div>
      <div class="top-pagination-content form-inline clearfix">
        {include file="$tpl_dir./pagination.tpl" no_follow=1}
      </div>
    </div>

    <ul id="suppliers_list" class="list-grid row">
      {foreach from=$suppliers_list item=supplier}
        <li class="col-xs-6 col-sm-4 col-md-3">
          <div class="thumbnail">
            <a href="{$link->getsupplierLink($supplier.id_supplier, $supplier.link_rewrite)|escape:'html':'UTF-8'}" title="{$supplier.name|escape:'html':'UTF-8'}">
              {if !empty($lazy_load)}
                <noscript>
                  <img src="{Link::getGenericImageLink(
                           'suppliers',
                           $supplier.id_supplier,
                           'medium_default',
                           (ImageManager::retinaSupport()) ? '2x' : ''
                       )|escape:'htmlall':'UTF-8'}"
                       alt="{$supplier.name|escape:'htmlall':'UTF-8'}"
                       width="{$mediumDefaultWidth}"
                       height="{$mediumDefaultHeight}"
                  >
                </noscript>
              {/if}
              <picture class="img-responsive{if !empty($lazy_load)} tb-lazy-image{/if}">
                <!--[if IE 9]>
                <video style="display: none;"><![endif]-->
                {if !empty($webp)}
                  <source {if !empty($lazy_load)}srcset="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII= 1w"
                          data-{/if}srcset="{Link::getGenericImageLink(
                              'suppliers',
                              $supplier.id_supplier,
                              'medium_default',
                              (ImageManager::retinaSupport()) ? '2x' : '',
                              true
                          )|escape:'htmlall':'UTF-8'}"
                          sizes="1px"
                          type="image/webp"
                  />
                {/if}
                <!--[if IE 9]></video><![endif]-->
                <img {if !empty($lazy_load)}srcset="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII= 1w"
                     data-{/if}srcset="{Link::getGenericImageLink(
                         'suppliers',
                         $supplier.id_supplier,
                         'medium_default',
                         (ImageManager::retinaSupport()) ? '2x' : ''
                     )|escape:'htmlall':'UTF-8'}"
                     {if !empty($lazy_load)}src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII="{/if}
                     sizes="1px"
                     alt="{$supplier.name|escape:'htmlall':'UTF-8'}"
                     width="{$mediumDefaultWidth}"
                     height="{$mediumDefaultHeight}"
                >
              </picture>
            </a>
            <div class="caption">
              <h3 class="text-center">
                <a class="product-name" href="{$link->getsupplierLink($supplier.id_supplier, $supplier.link_rewrite)|escape:'html':'UTF-8'}">
                  {$supplier.name|escape:'html':'UTF-8'}
                </a>
              </h3>
              {if isset($supplier.nb_products)}
                <p class="text-center">
                  {if $supplier.nb_products == 1}
                    {l s='%d product' sprintf=$supplier.nb_products|intval}
                  {else}
                    {l s='%d products' sprintf=$supplier.nb_products|intval}
                  {/if}
                </p>
              {/if}
              {if !empty($supplier.description)}
                <div class="rte">{$supplier.description}</div>
              {/if}
            </div>
          </div>
        </li>
      {/foreach}
    </ul>

    <div class="content_sortPagiBar">
      <div class="bottom-pagination-content form-inline clearfix">
        {include file="$tpl_dir./pagination.tpl" no_follow=1 paginationId='bottom'}
      </div>
    </div>

  {/if}
{/if}
