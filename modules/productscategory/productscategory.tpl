{if count($categoryProducts) > 0 && $categoryProducts !== false}
  <section class="page-product-box blockproductscategory">
    <h3 class="productscategory_h3 page-product-heading">
      {if $categoryProducts|@count == 1}
        {l s='%s other product in the same category:' sprintf=[$categoryProducts|@count] mod='productscategory'}
      {else}
        {l s='%s other products in the same category:' sprintf=[$categoryProducts|@count] mod='productscategory'}
      {/if}
    </h3>
    <div id="productscategory_list" class="clearfix">
      <ul id="bxslider1" class="bxslider clearfix">
        {foreach from=$categoryProducts item='categoryProduct' name=categoryProduct}
          <li class="product-box">
            <a href="{$link->getProductLink($categoryProduct.id_product, $categoryProduct.link_rewrite, $categoryProduct.category, $categoryProduct.ean13)}"
               class="lnk_img product-image"
               title="{$categoryProduct.name|htmlspecialchars}"
            >
              {if !empty($lazy_load)}
                <noscript>
                  <img src="{$link->getImageLink($categoryProduct.link_rewrite, $categoryProduct.id_image, 'home_default', null, ImageManager::retinaSupport())|escape:'html':'UTF-8'}"
                       alt="{$categoryProduct.name|htmlspecialchars}"
                       width="{getWidthSize|intval type='home_default'}"
                       height="{getHeightSize|intval type='home_default'}"
                  >
                </noscript>
              {/if}
              <picture {if !empty($lazy_load)}class="tb-lazy-image"{/if}>
                <!--[if IE 9]><video style="display: none;"><![endif]-->
                {if !empty($webp)}
                  <source {if !empty($lazy_load)}srcset="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII= 1w" data-{/if}srcset="{$link->getImageLink($categoryProduct.link_rewrite, $categoryProduct.id_image, 'home_default', 'webp', ImageManager::retinaSupport())|escape:'html':'UTF-8'}"
                          alt="{$categoryProduct.name|htmlspecialchars}"
                          type="image/webp"
                  >
                {/if}
                <!--[if IE 9]></video><![endif]-->
                <img {if !empty($lazy_load)}srcset="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII= 1w" data-{/if}srcset="{$link->getImageLink($categoryProduct.link_rewrite, $categoryProduct.id_image, 'home_default', null, ImageManager::retinaSupport())|escape:'html':'UTF-8'}"
                     {if !empty($lazy_load)}src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII="{/if}
                     alt="{$categoryProduct.name|htmlspecialchars}"
                     width="{getWidthSize|intval type='home_default'}"
                     height="{getHeightSize|intval type='home_default'}"
                >
              </picture>
            </a>
            <h5 class="product-name">
              <a href="{$link->getProductLink($categoryProduct.id_product, $categoryProduct.link_rewrite, $categoryProduct.category, $categoryProduct.ean13)|escape:'html':'UTF-8'}" title="{$categoryProduct.name|htmlspecialchars}">{$categoryProduct.name|truncate:14:'...'|escape:'html':'UTF-8'}</a>
            </h5>
            {if $ProdDisplayPrice && $categoryProduct.show_price == 1 && !isset($restricted_country_mode) && !$PS_CATALOG_MODE}
              <p class="price_display">
                {if isset($categoryProduct.specific_prices) && $categoryProduct.specific_prices
                && ($categoryProduct.displayed_price|number_format:2 !== $categoryProduct.price_without_reduction|number_format:2)}

                  <span class="price special-price">{convertPrice price=$categoryProduct.displayed_price}</span>
                  {if $categoryProduct.specific_prices.reduction && $categoryProduct.specific_prices.reduction_type == 'percentage'}
                    <span class="price-percent-reduction small">-{$categoryProduct.specific_prices.reduction * 100}%</span>
                  {/if}
                  <span class="old-price">{displayWtPrice p=$categoryProduct.price_without_reduction}</span>

                {else}
                  <span class="price">{convertPrice price=$categoryProduct.displayed_price}</span>
                {/if}
              </p>
            {else}
              <br>
            {/if}
            <div class="clearfix" style="margin-top:5px">
              {if !$PS_CATALOG_MODE && ($categoryProduct.allow_oosp || $categoryProduct.quantity > 0)}
                <div class="no-print">
                  <a class="button ajax_add_to_cart_button" href="{$link->getPageLink('cart', true, NULL, "qty=1&amp;id_product={$categoryProduct.id_product|intval}&amp;token={$static_token}&amp;add")|escape:'html':'UTF-8'}" data-id-product="{$categoryProduct.id_product|intval}" title="{l s='Add to cart' mod='productscategory'}">
                    <span>{l s='Add to cart' mod='productscategory'}</span>
                  </a>
                </div>
              {/if}
            </div>
          </li>
        {/foreach}
      </ul>
    </div>
  </section>
{/if}
