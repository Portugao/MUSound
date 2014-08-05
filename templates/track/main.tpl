{* purpose of this template: tracks main view *}
{assign var='lct' value='user'}
{if isset($smarty.get.lct) && $smarty.get.lct eq 'admin'}
    {assign var='lct' value='admin'}
{/if}
{include file="`$lct`/header.tpl"}
<p>{gt text='Welcome to the track section of the M u sound application.'}</p>
{include file="`$lct`/footer.tpl"}
