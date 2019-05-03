{*
 * 2007-2016 PrestaShop
 *
 * Thirty Bees is an extension to the PrestaShop e-commerce software developed by PrestaShop SA
 * Copyright (C) 2017-2019 thirty bees
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License (AFL 3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/afl-3.0.php
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@thirtybees.com so we can send you a copy immediately.
 *
 * @author    Thirty Bees <modules@thirtybees.com>
 * @author    PrestaShop SA <contact@prestashop.com>
 * @copyright 2017-2019 thirty bees
 * @copyright 2007-2016 PrestaShop SA
 * @license   https://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
 *  PrestaShop is an internationally registered trademark & property of PrestaShop SA
*}
<p id="loyalty" class="align_justify">
  {if $points}
    {l s='By buying this product you can collect up to' mod='loyalty'}
    <b><span id="loyalty_points">{$points}</span>&nbsp;{if $points > 1}{l s='loyalty points' mod='loyalty'}{else}{l s='loyalty point' mod='loyalty'}{/if}</b>.
    {l s='Your cart will total' mod='loyalty'}
    <b><span id="total_loyalty_points">{$total_points}</span>
      {if $total_points > 1}{l s='points' mod='loyalty'}{else}{l s='point' mod='loyalty'}{/if}</b>
    {l s='that can be converted into a voucher of' mod='loyalty'}
    <span id="loyalty_price">{convertPrice price=$voucher}</span>.
  {else}
    {if isset($no_pts_discounted) && $no_pts_discounted == 1}
      {l s='No reward points for this product because there\'s already a discount.' mod='loyalty'}
    {else}
      {l s='No reward points for this product.' mod='loyalty'}
    {/if}
  {/if}
</p>
<br class="clearfix">
