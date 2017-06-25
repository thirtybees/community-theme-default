<section id="blockcategories-footer" class="blockcategories col-xs-12 col-sm-3">
  <span class="footer-title">{l s='Categories' mod='blockcategories'}</span>
  <ul class="list-unstyled">
    {foreach from=$blockCategTree.children item=child}
      {include file='./footer_list_item.tpl' item=$child}
    {/foreach}
  </ul>
</section>
