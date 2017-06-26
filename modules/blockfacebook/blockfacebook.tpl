{if !empty($facebookurl)}
    <section>
        <div id="blockfacebook" class="col-xs-12 col-sm-4">
            <span class="title">{l s='Follow us on Facebook' mod='blockfacebook'}</span>
            <div id="fb-like-box-container" style="overflow: hidden;">
                <div class="fb-page" data-href="{$facebookurl|escape:'html':'UTF-8'}" data-width="360"
                     data-small-header="false" data-adapt-container-width="true" data-hide-cover="false"
                     data-show-facepile="true"></div>
            </div>
        </div>
        <div id="fb-root"></div>
    </section>
{/if}
