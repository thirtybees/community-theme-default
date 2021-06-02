{capture name=path}<a href="{$link->getPageLink('authentication', true)|escape:'html':'UTF-8'}" title="{l s='Authentication'}" rel="nofollow">{l s='Authentication'}</a><span class="navigation-pipe">{$navigationPipe}</span>{l s='Set new password'}{/capture}
<div class="box">
  <h1 class="page-subheading">{l s='Set new password'}</h1>

  {include file="$tpl_dir./errors.tpl"}
  {if isset($confirmation) && $confirmation == 1}
    <div class="alert alert-success">{l s='Your password has been changed'}</div>
  {else}
    <p>{l s='Please enter new password for [1]%s[/1]' sprintf=[$customer->email] tags=['<b>']}</p>
    <form action="{$link->getPageLink('password', true)|escape:'html':'UTF-8'}" method="post">
      <fieldset>
        <input type="hidden" name="username" value="{$customer->email}" />
        <input type="hidden" name="token" value="{$customer->secure_key}" />
        <input type="hidden" name="id_customer" value="{$customer->id}" />
        <div class="form-group">
          <label for="email">{l s='Password'}</label>
          <input class="form-control" type="password" id="password" name="password" autocomplete="new-password" required>
        </div>
        <div class="form-group">
          <label for="email">{l s='Confirm password'}</label>
          <input class="form-control" type="password" id="confirm_password" name="confirm_password" autocomplete="new-password" required>
        </div>
        <div class="submit">
          <button type="submit" class="btn btn-lg btn-success"><span>{l s='Change password'} <i class="icon icon-chevron-right"></i></span></button>
        </div>
      </fieldset>
    </form>
  {/if}
</div>

<nav>
  <ul class="pager">
    <li class="previous">
      <a href="{$link->getPageLink('authentication')|escape:'html':'UTF-8'}" title="{l s='Back to Login'}">
        {if $isRtl}&rarr;{else}&larr;{/if} {l s='Back to Login'}
      </a>
    </li>
  </ul>
</nav>
