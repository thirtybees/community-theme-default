<section>
    <div id="viewed-products_block_left" class="block">
        <h2 class="title_block section-title-column">{l s='Viewed products' mod='blockviewed'}</h2>
        <div class="block_content products-block">
            <ul>
                {foreach from=$productsViewedObj item=viewedProduct name=myLoop}
                    <li class="clearfix">
                        <article>
                            <a class="products-block-image"
                               href="{$viewedProduct->product_link|escape:'html':'UTF-8'}"
                               title="{l s='More about %s' mod='blockviewed' sprintf=[$viewedProduct->name|escape:'html':'UTF-8']}"
                            >
                              {if !empty($lazy_load)}
                                <noscript>
                                  <img src="{if isset($viewedProduct->id_image) && $viewedProduct->id_image}{$link->getImageLink($viewedProduct->link_rewrite, $viewedProduct->cover, 'small_default', null, ImageManager::retinaSupport())}{else}{$img_prod_dir}{$lang_iso}-default-medium_default.jpg{/if}"
                                       alt="{$viewedProduct->legend|escape:'html':'UTF-8'}"
                                       width="{getWidthSize|intval type='small_default'}"
                                       height="{getHeightSize|intval type='small_default'}"
                                  >
                                </noscript>
                              {/if}
                              <picture {if !empty($lazy_load)}class="tb-lazy-image"{/if}>
                                <!--[if IE 9]><video style="display: none;"><![endif]-->
                                {if !empty($webp)}
                                  <source {if !empty($lazy_load)}srcset="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII= 1w" data-{/if}srcset="{if isset($viewedProduct->id_image) && $viewedProduct->id_image}{$link->getImageLink($viewedProduct->link_rewrite, $viewedProduct->cover, 'small_default', 'webp', ImageManager::retinaSupport())}{else}{$img_prod_dir}{$lang_iso}-default-medium_default.webp{/if}"
                                          type="image/webp"
                                  >
                                {/if}
                                <!--[if IE 9]></video><![endif]-->
                                <img {if !empty($lazy_load)}srcset="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII= 1w" data-{/if}srcset="{if isset($viewedProduct->id_image) && $viewedProduct->id_image}{$link->getImageLink($viewedProduct->link_rewrite, $viewedProduct->cover, 'small_default', null, ImageManager::retinaSupport())}{else}{$img_prod_dir}{$lang_iso}-default-medium_default.jpg{/if}"
                                     {if !empty($lazy_load)}src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII="{/if}
                                     alt="{$viewedProduct->legend|escape:'html':'UTF-8'}"
                                     width="{getWidthSize|intval type='small_default'}"
                                     height="{getHeightSize|intval type='small_default'}"
                                >
                              </picture>
                            </a>
                            <div class="product-content">
            <span>
              <a class="product-name"
                 href="{$viewedProduct->product_link|escape:'html':'UTF-8'}"
                 title="{l s='More about %s' mod='blockviewed' sprintf=[$viewedProduct->name|escape:'html':'UTF-8']}">
                {$viewedProduct->name|truncate:25:'...'|escape:'html':'UTF-8'}
              </a>
            </span>
                                <p class="product-description">{$viewedProduct->description_short|strip_tags:'UTF-8'|truncate:40}</p>
                            </div>
                        </article>
                    </li>
                {/foreach}
            </ul>
        </div>
    </div>
</section>
