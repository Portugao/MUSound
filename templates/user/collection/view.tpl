{* purpose of this template: collections view view in user area *}
{include file='user/header.tpl'}
<div class="musound-collection musound-view">
    {gt text='Collection list' assign='templateTitle'}
    {pagesetvar name='title' value=$templateTitle}
    <h2>{$templateTitle}</h2>

    {if $canBeCreated}
        {checkpermissionblock component='MUSound:Collection:' instance='::' level='ACCESS_EDIT'}
            {gt text='Create collection' assign='createTitle'}
            <a href="{modurl modname='MUSound' type='user' func='edit' ot='collection'}" title="{$createTitle}" class="z-icon-es-add">{$createTitle}</a>
        {/checkpermissionblock}
    {/if}
    {assign var='own' value=0}
    {if isset($showOwnEntries) && $showOwnEntries eq 1}
        {assign var='own' value=1}
    {/if}
    {assign var='all' value=0}
    {if isset($showAllEntries) && $showAllEntries eq 1}
        {gt text='Back to paginated view' assign='linkTitle'}
        <a href="{modurl modname='MUSound' type='user' func='view' ot='collection'}" title="{$linkTitle}" class="z-icon-es-view">
            {$linkTitle}
        </a>
        {assign var='all' value=1}
    {else}
        {gt text='Show all entries' assign='linkTitle'}
        <a href="{modurl modname='MUSound' type='user' func='view' ot='collection' all=1}" title="{$linkTitle}" class="z-icon-es-view">{$linkTitle}</a>
    {/if}

    {include file='user/collection/view_quickNav.tpl' all=$all own=$own workflowStateFilter=false}{* see template file for available options *}

    <table class="z-datatable">
        <colgroup>
            <col id="cTitle" />
            <col id="cDescription" />
            <col id="cItemActions" />
        </colgroup>
        <thead>
        <tr>
            <th id="hTitle" scope="col" class="z-left">
                {sortlink __linktext='Title' currentsort=$sort modname='MUSound' type='user' func='view' ot='collection' sort='title' sortdir=$sdir all=$all own=$own workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
            </th>
            <th id="hDescription" scope="col" class="z-left">
                {sortlink __linktext='Description' currentsort=$sort modname='MUSound' type='user' func='view' ot='collection' sort='description' sortdir=$sdir all=$all own=$own workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
            </th>
            <th id="hItemActions" scope="col" class="z-right z-order-unsorted">{gt text='Actions'}</th>
        </tr>
        </thead>
        <tbody>
    
    {foreach item='collection' from=$items}
        <tr class="{cycle values='z-odd, z-even'}">
            <td headers="hTitle" class="z-left">
                <a href="{modurl modname='MUSound' type='user' func='display' ot='collection' id=$collection.id}" title="{gt text='View detail page'}">{$collection.title|notifyfilters:'musound.filterhook.collections'}</a>
            </td>
            <td headers="hDescription" class="z-left">
                {$collection.description}
            </td>
            <td id="itemActions{$collection.id}" headers="hItemActions" class="z-right z-nowrap z-w02">
                {if count($collection._actions) gt 0}
                    {foreach item='option' from=$collection._actions}
                        <a href="{$option.url.type|musoundActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}"{if $option.icon eq 'preview'} target="_blank"{/if}>{icon type=$option.icon size='extrasmall' alt=$option.linkText|safetext}</a>
                    {/foreach}
                    {icon id="itemActions`$collection.id`Trigger" type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}
                    <script type="text/javascript">
                    /* <![CDATA[ */
                        document.observe('dom:loaded', function() {
                            musoundInitItemActions('collection', 'view', 'itemActions{{$collection.id}}');
                        });
                    /* ]]> */
                    </script>
                {/if}
            </td>
        </tr>
    {foreachelse}
        <tr class="z-datatableempty">
          <td class="z-left" colspan="3">
        {gt text='No collections found.'}
          </td>
        </tr>
    {/foreach}
    
        </tbody>
    </table>
    
    {if !isset($showAllEntries) || $showAllEntries ne 1}
        {pager rowcount=$pager.numitems limit=$pager.itemsperpage display='page' modname='MUSound' type='user' func='view' ot='collection'}
    {/if}

    
    {notifydisplayhooks eventname='musound.ui_hooks.collections.display_view' urlobject=$currentUrlObject assign='hooks'}
    {foreach key='providerArea' item='hook' from=$hooks}
        {$hook}
    {/foreach}
</div>
{include file='user/footer.tpl'}
