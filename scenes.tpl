{if $scenes}
  <div id="scenes">
    <div>
      {foreach $scenes as $scene_key=>$scene}
        <div id="screen_scene_{$scene->id_scene}"
             class="screen_scene"
             style="background:transparent url({Link::getGenericImageLink(
                 'scenes',
                 $scene->id_scene,
                 'scene_default',
                 (ImageManager::retinaSupport()) ? '2x' : ''
             )|escape:'htmlall':'UTF-8'});
             height: {$largeSceneImageType.height|intval}px;
             width: {$largeSceneImageType.width|intval}px;
             {if !$scene@first} display:none;{/if}"
        >
          {foreach $scene->products as $product_key=>$product}
            {if isset($product.id_image)}
              {assign var=imageIds value="`$product.id_product`-`$product.id_image`"}
            {/if}
            <a href="{$product.link|escape:'html':'UTF-8'}" class="popover-button" style="width:{$product.zone_width}px; height:{$product.zone_height}px; margin-left:{$product.x_axis}px ;margin-top:{$product.y_axis}px;" data-id_product_scene="{$scene_key|intval}_{$product_key|intval}_{$product.id_product|intval}">
              <span style="margin-top:{math equation='a/2 -10' a=$product.zone_height}px; margin-left:{math equation='a/2 -10' a=$product.zone_width}px;"></span>
            </a>
            <div id="scene_products_cluetip_{$scene_key}_{$product_key}_{$product.id_product}" style="display:none;">
              <div class="product-image-container">
                {if isset($imageIds)}
                  {if !empty($lazy_load)}
                    <noscript>
                      <img src="{$link->getImageLink($product.id_product, $imageIds, 'home_default', null, ImageManager::retinaSupport())|escape:'html':'UTF-8'}"
                           alt=""
                           width="{getWidthSize|intval type='home_default'}"
                           height="{getWidthSize|intval type='home_default'}"
                      >
                    </noscript>
                  {/if}
                  <picture class="img-responsive{if !empty($lazy_load)} tb-lazy-image{/if}">
                    <!--[if IE 9]><video style="display: none;"><![endif]-->
                    {if !empty($webp)}
                      <source {if !empty($lazy_load)}srcset="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII= 1w" data-{/if}srcset="{$link->getImageLink($product.id_product, $imageIds, 'home_default', 'webp', ImageManager::retinaSupport())|escape:'html':'UTF-8'}"
                              type="image/webp"
                      >
                    {/if}
                    <!--[if IE 9]></video><![endif]-->
                    <img {if !empty($lazy_load)}srcset="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII= 1w" data-{/if}srcset="{$link->getImageLink($product.id_product, $imageIds, 'home_default', null, ImageManager::retinaSupport())|escape:'html':'UTF-8'}"
                         {if !empty($lazy_load)}src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII="{/if}
                         alt=""
                         width="{getWidthSize|intval type='home_default'}"
                         height="{getWidthSize|intval type='home_default'}"
                    >
                  </picture>
                {/if}
              </div>
              <p class="product-name"><span class="product_name">{$product.details->name|escape:'html':'UTF-8'}</span></p>
              <div class="description">{$product.details->description_short|strip_tags|truncate:170:'...'}</div>
              {if !$PS_CATALOG_MODE && $product.details->show_price}
                <div class="prices">
                  {if isset($product.details->online_only) && $product.details->online_only}
                    <span class="product-label product-label-online">{l s='Online only'}</span>
                  {/if}
                  {if isset($product.details->new) && $product.details->new}
                    <span class="product-label product-label-new">{l s='New'}</span>
                  {/if}
                  <p class="price product-price">{if $priceDisplay}{convertPrice price=$product.details->getPrice(false, $product.details->getDefaultAttribute($product.id_product))}{else}{convertPrice price=$product.details->getPrice(true, $product.details->getDefaultAttribute($product.id_product))}{/if}</p>
                  {if $product.details->on_sale}
                    <span class="product-label product-label-sale">{l s='Sale'}</span>
                  {elseif isset($product.reduction) && $product.reduction}
                    <span class="product-label product-label-discount">{l s='Reduced price!'}</span>
                  {/if}
                </div>
              {/if}
            </div>
          {/foreach}
        </div>
      {/foreach}
    </div>
    {if isset($scenes.1)}
      <div class="thumbs_banner" style="height:{$thumbSceneImageType.height}px;">
        <span class="space-keeper">
            <a class="prev" href="#" style="height:{math equation='a+2' a=$thumbSceneImageType.height}px;">&nbsp;</a>
        </span>
        <div id="scenes_list">
          <ul style="width:{math equation='(a*b + (a-1)*10)' a=$scenes|@count b=$thumbSceneImageType.width}px; height:{$thumbSceneImageType.height}px;">
            {foreach $scenes as $scene}
              <li id="scene_thumb_{$scene->id_scene}" style="{if !$scene@last} padding-right:10px;{/if}">
                <a style="width:{$thumbSceneImageType.width}px; height:{$thumbSceneImageType.height}px" title="{$scene->name|escape:'html':'UTF-8'}" href="{if isset($force_ssl) && $force_ssl}{$base_dir_ssl}{else}{$base_dir}{/if}" data-id_scene="{$scene->id_scene|intval}" class="scene_thumb">
                  <img alt="{$scene->name|escape:'html':'UTF-8'}"
                       src="{Link::getGenericImageLink(
                           'scenes_thumbs',
                           $scene->id_scene,
                           'm_scene_default',
                           (ImageManager::retinaSupport()) ? '2x' : ''
                       )|escape:'htmlall':'UTF-8'}"
                       width="{$thumbSceneSize.width|intval}"
                       height="{$thumbSceneSize.height|intval}"
                  >
                </a>
              </li>
            {/foreach}
          </ul>
        </div>
        <span class="space-keeper">
            <a class="next" href="{if isset($force_ssl) && $force_ssl}{$base_dir_ssl}{else}{$base_dir}{/if}" style="height:{math equation='a+2' a=$thumbSceneImageType.height}px;">&nbsp;</a>
        </span>
      </div>
    {/if}
  </div>
  {strip}
    {addJsDefL name=i18n_scene_close}{l s='Close' js=1}{/addJsDefL}
    {addJsDef li_width=($thumbSceneImageType.width|intval+10)}
  {/strip}
{/if}
