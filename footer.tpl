{if !isset($content_only) || !$content_only}
      </main>{* #center_column *}
    {if isset($right_column_size) && !empty($right_column_size)}
      <aside id="right_column" class="col-xs-12 col-sm-{$right_column_size|intval}" role="navigation complementary">{$HOOK_RIGHT_COLUMN}</aside>
    {/if}
    </div>{* .row *}
  </div>{* #columns*}
  <footer id="footer">
    {if isset($HOOK_FOOTER)}
      <div class="container">
        <div class="row">{$HOOK_FOOTER}</div>
      </div>
    {/if}
    {if !empty($ctheme.footer.copyright.display)}
      <div id="copyright-footer" role="contentinfo">
		<div class="container">
			<div class="sloganfoot">{$ctheme.footer.copyright.html}</div>
			<a href="#" target="_self" title="{l s='secure payment'}">
				<img src="{$img_dir}payment-logos.png" class="footlogos" width="360" height="60">
			</a>
			<a href="#" target="_self" title="{l s='Delivery options'}">
				<img src="{$img_dir}logos_transporteurs.png" class="footlogos espace" width="360" height="60">
			</a>
		</div>
      </div> 
    {/if}
  </footer>
{/if}
{include file="$tpl_dir./global.tpl"}
</body>
</html>
