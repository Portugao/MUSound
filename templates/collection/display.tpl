{* purpose of this template: collections display view *}
{assign var='lct' value='user'}
{if isset($smarty.get.lct) && $smarty.get.lct eq 'admin'}
    {assign var='lct' value='admin'}
{/if}
{include file="`$lct`/header.tpl"}
<div class="musound-collection musound-display with-rightbox">
    {gt text='Collection' assign='templateTitle'}
    {assign var='templateTitle' value=$collection->getTitleFromDisplayPattern()|default:$templateTitle}
    {pagesetvar name='title' value=$templateTitle|@html_entity_decode}
    {if $lct eq 'admin'}
        <div class="z-admin-content-pagetitle">
            {icon type='display' size='small' __alt='Details'}
            <h3>{$templateTitle|notifyfilters:'musound.filter_hooks.collections.filter'}{icon id="itemActions`$collection.id`Trigger" type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}
            </h3>
        </div>
    {else}
        <h2>{$templateTitle|notifyfilters:'musound.filter_hooks.collections.filter'}{icon id="itemActions`$collection.id`Trigger" type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}
        </h2>
    {/if}

    {if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
        <div class="musound-rightbox">
            {if $lct eq 'admin'}
                <h4>{gt text='Albums'}</h4>
            {else}
                <h3>{gt text='Albums'}</h3>
            {/if}
            
            {if isset($collection.album) && $collection.album ne null}
                {include file='album/includeDisplayItemListMany.tpl' items=$collection.album}
            {/if}
            
            {assign var='permLevel' value='ACCESS_EDIT'}
            {if $lct eq 'admin'}
                {assign var='permLevel' value='ACCESS_ADMIN'}
            {/if}
            {checkpermission component='MUSound:Collection:' instance='`$collection.id`::' level=$permLevel assign='mayManage'}
            {if $mayManage || (isset($uid) && isset($collection.createdUserId) && $collection.createdUserId eq $uid)}
            <p class="managelink">
                {gt text='Create album' assign='createTitle'}
                <a href="{modurl modname='MUSound' type=$lct func='edit' ot='album' collection="`$collection.id`" returnTo="`$lct`DisplayCollection"'}" title="{$createTitle}" class="z-icon-es-add">{$createTitle}</a>
            </p>
            {/if}
        </div>
    {/if}

    <dl>
        <dt>{gt text='Title'}</dt>
        <dd>{$collection.title}</dd>
        <dt>{gt text='Description'}</dt>
        <dd>{$collection.description|safehtml}</dd>
        
    </dl>
    {include file='helper/includeStandardFieldsDisplay.tpl' obj=$collection}

    {if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
        {* include display hooks *}
        {notifydisplayhooks eventname='musound.ui_hooks.collections.display_view' id=$collection.id urlobject=$currentUrlObject assign='hooks'}
        {foreach name='hookLoop' key='providerArea' item='hook' from=$hooks}
            {if $providerArea ne 'provider.scribite.ui_hooks.editor'}{* fix for #664 *}
                {$hook}
            {/if}
        {/foreach}
        {if count($collection._actions) gt 0}
            <p id="itemActions{$collection.id}">
                {foreach item='option' from=$collection._actions}
                    <a href="{$option.url.type|musoundActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}" class="z-icon-es-{$option.icon}">{$option.linkText|safetext}</a>
                {/foreach}
            </p>
            <script type="text/javascript">
            /* <![CDATA[ */
                document.observe('dom:loaded', function() {
                    mUMUSoundInitItemActions('collection', 'display', 'itemActions{{$collection.id}}');
                });
            /* ]]> */
            </script>
        {/if}
        <br style="clear: right" />
    {/if}
</div>
{include file="`$lct`/footer.tpl"}
