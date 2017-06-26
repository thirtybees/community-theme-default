<section>
    <div id="viewed-products_block_left" class="block">
        <h2 class="title_block section-title-column">{l s='Viewed products' mod='blockviewed'}</h2>
        <div class="block_content products-block">
            <ul>
                {foreach from=$productsViewedObj item=viewedProduct name=myLoop}
                    <li class="clearfix">
                        <article>
                            <a
                                    class="products-block-image"
                                    href="{$viewedProduct->product_link|escape:'html':'UTF-8'}"
                                    title="{l s='More about %s' mod='blockviewed' sprintf=[$viewedProduct->name|escape:'html':'UTF-8']}">
                                <img
                                        src="{if isset($viewedProduct->id_image) && $viewedProduct->id_image}{$link->getImageLink($viewedProduct->link_rewrite, $viewedProduct->cover, 'small_default')}{else}{$img_prod_dir}{$lang_iso}-default-medium_default.jpg{/if}"
                                        alt="{$viewedProduct->legend|escape:'html':'UTF-8'}"/>
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