{if isset($orderProducts) && is_array($orderProducts) && !empty($orderProducts)}
    <section id="crossselling" class="page-product-box">
        <h2 class="productscategory_h2 page-product-heading">
            {if $page_name == 'product'}
                {l s='Customers who bought this product also bought:' mod='crossselling'}
            {else}
                {l s='We recommend' mod='crossselling'}
            {/if}
        </h2>
        <div id="crossselling_list">
            <ul id="crossselling_list_car" class="clearfix">
                {foreach from=$orderProducts item='orderProduct' name=orderProduct}
                    <li class="product-box" itemprop="isRelatedTo" itemscope itemtype="https://schema.org/Product">
                        <article>
                            <a class="lnk_img product-image" href="{$orderProduct.link|escape:'html':'UTF-8'}"
                               title="{$orderProduct.name|htmlspecialchars}">
                                <img itemprop="image" src="{$orderProduct.image}"
                                     alt="{$orderProduct.name|htmlspecialchars}"
                                     title="{$orderProduct.name|htmlspecialchars}">
                            </a>
                            <div class="s_title_block">
                                <h3 itemprop="name" class="product-name">
                                    <a itemprop="url" href="{$orderProduct.link|escape:'html':'UTF-8'}"
                                       title="{$orderProduct.name|htmlspecialchars}">
                                        {$orderProduct.name|truncate:15:'...'|escape:'html':'UTF-8'}
                                    </a>
                                </h3>

                                {if isset($orderProduct.description_short)}
                                    <p>{$orderProduct.description_short|strip_tags:'UTF-8'|truncate:50:'...'}</p>{/if}
                            </div>
                            {if $crossDisplayPrice && $orderProduct.show_price == 1 && !isset($restricted_country_mode) && !$PS_CATALOG_MODE}
                                <p class="price_display">
                                    <span class="price">{convertPrice price=$orderProduct.displayed_price}</span>
                                </p>
                            {/if}
                            <div class="clearfix" style="margin-top:5px">
                                {if !$PS_CATALOG_MODE && ($orderProduct.allow_oosp || $orderProduct.quantity > 0)}
                                    <div class="no-print">
                                        <a class="button ajax_add_to_cart_button"
                                           href="{$link->getPageLink('cart', true, NULL, "qty=1&amp;id_product={$orderProduct.id_product|intval}&amp;token={$static_token}&amp;add")|escape:'html':'UTF-8'}"
                                           data-id-product="{$orderProduct.id_product|intval}"
                                           title="{l s='Add to cart' mod='crossselling'}">
                                            <span>{l s='Add to cart' mod='crossselling'}</span>
                                        </a>
                                    </div>
                                {/if}
                            </div>
                        </article>
                    </li>
                {/foreach}
            </ul>
        </div>
    </section>
{/if}
