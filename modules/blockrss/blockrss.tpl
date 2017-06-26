<section>
    <div id="rss_block_left" class="block">
        <h2 class="title_block section-title-column">{$title}</h2>
        <div class="block_content">
            {if $rss_links}
                <ul>
                    {foreach from=$rss_links item='rss_link'}
                        <li><a href="{$rss_link.url}">{$rss_link.title}</a></li>
                    {/foreach}
                </ul>
            {else}
                <p>{l s='No RSS feed added' mod='blockrss'}</p>
            {/if}
        </div>
    </div>
</section>