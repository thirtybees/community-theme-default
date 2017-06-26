<section>
    <div id="tags_block_left" class="block tags_block">
        <h2 class="title_block section-title-column">
            {l s='Tags' mod='blocktags'}
        </h2>
        <div class="block_content">
            {if $tags}
                {foreach from=$tags item=tag name=myLoop}
                    <a
                            class="{$tag.class}"
                            href="{$link->getPageLink('search', true, NULL, "tag={$tag.name|urlencode}")|escape:'html':'UTF-8'}"
                            title="{l s='More about' mod='blocktags'} {$tag.name|escape:'html':'UTF-8'}"
                    >
                        {$tag.name|escape:'html':'UTF-8'}
                    </a>
                {/foreach}
            {else}
                {l s='No tags specified yet' mod='blocktags'}
            {/if}
        </div>
    </div>
</section>