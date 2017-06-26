<section>
    <div id="contact_block" class="block">
        <h2 class="title_block section-title-column">
            {l s='Contact Us' mod='blockcontact'}
        </h2>
        <div class="block_content clearfix">
            <p>
                {l s='Our support hotline is available 24/7.' mod='blockcontact'}
            </p>
            {if $telnumber != ''}
                <p class="tel">
                    <span class="label">{l s='Phone:' mod='blockcontact'}</span>
                    <a href="tel:{$telnumber|escape:'html':'UTF-8'}" title="{$telnumber|escape:'html':'UTF-8'}">{$telnumber|escape:'html':'UTF-8'}</a>
                </p>
            {/if}
            {if $email != ''}
                <address>
                    <a href="mailto:{$email|escape:'html':'UTF-8'}"
                       title="{l s='Contact our expert support team!' mod='blockcontact'}">
                        {l s='Contact our expert support team!' mod='blockcontact'}
                    </a>
                </address>
            {/if}
        </div>
    </div>
</section>
