{capture name=path}{l s='Manufacturers:'}{/capture}

{assign var='mediumDefaultWidth' value={getWidthSize|intval type='medium_default'}}
{assign var='mediumDefaultHeight' value={getHeightSize|intval type='medium_default'}}
{if ImageManager::retinaSupport()}
  {assign var='mediumDefaultWidth' value=$mediumDefaultWidth * 2}
  {assign var='mediumDefaultHeight' value=$mediumDefaultHeight * 2}
{/if}

<div class="product-listing page-heading">
  <h1 class="pull-left product-listing-title">{l s='Brands'}</h1>
  <div class="pull-right">
      <span class="heading-counter badge">
        {if $nbManufacturers == 0}
          {l s='There are no manufacturers.'}
        {else}
          {if $nbManufacturers == 1}
            {l s='There is 1 brand'}
          {else}
            {l s='There are %d brands' sprintf=$nbManufacturers}
          {/if}
        {/if}
      </span>
  </div>
</div>

{if isset($errors) AND $errors}
  {include file="$tpl_dir./errors.tpl"}
{else}
  {if $nbManufacturers > 0}

    <div class="content_sortPagiBar clearfix">
      <div class="form-inline sortPagiBar clearfix">
        {if isset($manufacturer) && isset($manufacturer.nb_products) && $manufacturer.nb_products > 0}
          {include file='./product-list-switcher.tpl'}
        {/if}
        {include file="./nbr-product-page.tpl"}
      </div>
      <div class="top-pagination-content form-inline clearfix">
        {include file="$tpl_dir./pagination.tpl" no_follow=1}
      </div>
    </div>

    <ul id="manufacturers_list" class="list-grid row">
      {foreach from=$manufacturers item=manufacturer}
        <li class="col-xs-6 col-sm-4 col-md-3">
          <div class="thumbnail">
            <a href="{$link->getmanufacturerLink($manufacturer.id_manufacturer, $manufacturer.link_rewrite)|escape:'html':'UTF-8'}" title="{$manufacturer.name|escape:'html':'UTF-8'}">
              {if !empty($lazy_load)}
                <noscript>
                  <img src="{Link::getGenericImageLink(
                           'manufacturers',
                           $manufacturer.id_manufacturer,
                           'medium_default',
                           (ImageManager::retinaSupport()) ? '2x' : ''
                       )|escape:'htmlall':'UTF-8'}"
                       alt="{$manufacturer.name|escape:'htmlall':'UTF-8'}"
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
                              'manufacturers',
                              $manufacturer.id_manufacturer,
                              'medium_default',
                              (ImageManager::retinaSupport()) ? '2x' : '',
                              true
                          )|escape:'htmlall':'UTF-8'}"
                          sizes="1px"
                          type="image/webp"
                  >
                {/if}
                <!--[if IE 9]></video><![endif]-->
                <img {if !empty($lazy_load)}srcset="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII= 1w"
                     data-{/if}srcset="{Link::getGenericImageLink(
                        'manufacturers',
                        $manufacturer.id_manufacturer,
                        'medium_default',
                        (ImageManager::retinaSupport()) ? '2x' : ''
                     )|escape:'htmlall':'UTF-8'}"
                     {if !empty($lazy_load)}src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII="{/if}
                     sizes="1px"
                     alt="{$manufacturer.name|escape:'htmlall':'UTF-8'}"
                     width="{$mediumDefaultWidth}"
                     height="{$mediumDefaultHeight}"
                >
              </picture>
            </a>
            <div class="caption">
              <h3 class="text-center">
                <a href="{$link->getmanufacturerLink($manufacturer.id_manufacturer, $manufacturer.link_rewrite)|escape:'html':'UTF-8'}">
                  {$manufacturer.name|escape:'html':'UTF-8'}
                </a>
              </h3>
              {if isset($manufacturer.nb_products)}
                <p class="text-center">
                  {if  $manufacturer.nb_products == 1}
                    {l s='%d product' sprintf=$manufacturer.nb_products|intval}
                  {else}
                    {l s='%d products' sprintf=$manufacturer.nb_products|intval}
                  {/if}
                </p>
              {/if}
              {if !empty($manufacturer.short_description)}
                <div class="rte">{$manufacturer.short_description}</div>
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
