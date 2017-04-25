{capture name=path}
  <a href="{$link->getPageLink('my-account', true)|escape:'html':'UTF-8'}">
    {l s='My account' mod='blockwishlist'}
  </a>
  <span class="navigation-pipe">
      {$navigationPipe}
    </span>
  <span class="navigation_page">
      {l s='My wishlists' mod='blockwishlist'}
    </span>
{/capture}

<div id="mywishlist">

  <h1 class="page-heading">{l s='My wishlists' mod='blockwishlist'}</h1>

  {include file="$tpl_dir./errors.tpl"}

  {if $id_customer|intval neq 0}
    <form method="post" class="std box" id="form_wishlist">
      <fieldset>
        <h3 class="page-subheading">{l s='New wishlist' mod='blockwishlist'}</h3>
        <div class="form-group">
          <input type="hidden" name="token" value="{$token|escape:'html':'UTF-8'}" />
          <label class="align_right" for="name">
            {l s='Name' mod='blockwishlist'}
          </label>
          <input type="text" id="name" name="name" class="inputTxt form-control" value="{if isset($smarty.post.name) and $errors|@count > 0}{$smarty.post.name|escape:'html':'UTF-8'}{/if}" />
        </div>
        <div class="submit">
          <button id="submitWishlist" class="btn btn-lg btn-success" type="submit" name="submitWishlist">
            <span>{l s='Save' mod='blockwishlist'} <i class="icon icon-chevron-right"></i></span>
          </button>
        </div>
      </fieldset>
    </form>
    {if $wishlists}
      <div id="block-history" class="block-center">
        <table class="table table-bordered">
          <thead>
          <tr>
            <th>{l s='Name' mod='blockwishlist'}</th>
            <th class="mywishlist_first">{l s='Qty' mod='blockwishlist'}</th>
            <th class="mywishlist_first">{l s='Viewed' mod='blockwishlist'}</th>
            <th class="mywishlist_second">{l s='Created' mod='blockwishlist'}</th>
            <th class="mywishlist_second">{l s='Direct Link' mod='blockwishlist'}</th>
            <th class="mywishlist_second">{l s='Default' mod='blockwishlist'}</th>
            <th class="mywishlist_first">{l s='Delete' mod='blockwishlist'}</th>
          </tr>
          </thead>
          <tbody>
          {section name=i loop=$wishlists}
            <tr id="wishlist_{$wishlists[i].id_wishlist|intval}">
              <td style="width:200px;">
                <a href="#" onclick="javascript:event.preventDefault();WishlistManage('block-order-detail', '{$wishlists[i].id_wishlist|intval}');">
                  {$wishlists[i].name|truncate:30:'...'|escape:'htmlall':'UTF-8'}
                </a>
              </td>
              <td class="bold align_center">
                {assign var=n value=0}
                {foreach from=$nbProducts item=nb name=i}
                  {if $nb.id_wishlist eq $wishlists[i].id_wishlist}
                    {assign var=n value=$nb.nbProducts|intval}
                  {/if}
                {/foreach}
                {if $n}
                  {$n|intval}
                {else}
                  0
                {/if}
              </td>
              <td>{$wishlists[i].counter|intval}</td>
              <td>{$wishlists[i].date_add|date_format:"%Y-%m-%d"}</td>
              <td>
                <a href="#" onclick="javascript:event.preventDefault();WishlistManage('block-order-detail', '{$wishlists[i].id_wishlist|intval}');">
                  {l s='View' mod='blockwishlist'}
                </a>
              </td>
              <td class="wishlist_default">
                {if isset($wishlists[i].default) && $wishlists[i].default == 1}
                  <p class="is_wish_list_default">
                    <i class="icon icon-check-square"></i>
                  </p>
                {else}
                  <a href="#" onclick="javascript:event.preventDefault();(WishlistDefault('wishlist_{$wishlists[i].id_wishlist|intval}', '{$wishlists[i].id_wishlist|intval}'));">
                    <i class="icon icon-square"></i>
                  </a>
                {/if}
              </td>
              <td class="wishlist_delete">
                <a href="#" onclick="javascript:event.preventDefault();return (WishlistDelete('wishlist_{$wishlists[i].id_wishlist|intval}', '{$wishlists[i].id_wishlist|intval}', '{l s='Do you really want to delete this wishlist ?' mod='blockwishlist' js=1}'));">
                  <i class="icon icon-remove"></i>
                </a>
              </td>
            </tr>
          {/section}
          </tbody>
        </table>
      </div>
      <div id="block-order-detail"></div>
    {/if}
  {/if}

</div>

<nav>
  <ul class="pager">
    <li class="previous">
      <a href="{$link->getPageLink('my-account', true)|escape:'html':'UTF-8'}" title="{l s='Back to your account' mod='blockwishlist'}">
        {if isset($isRtl) && $isRtl}&rarr;{else}&larr;{/if} {l s='Back to your account' mod='blockwishlist'}
      </a>
    </li>
  </ul>
</nav>
