{* purpose of this template: albums view view in user area *}
{include file='user/header.tpl'}
<div class="musound-album musound-view">
    {gt text='Album list' assign='templateTitle'}
    {pagesetvar name='title' value=$templateTitle}
    <h2>{$templateTitle}</h2>

    {if $canBeCreated}
        {checkpermissionblock component='MUSound:Album:' instance='::' level='ACCESS_COMMENT'}
            {gt text='Create album' assign='createTitle'}
            <a href="{modurl modname='MUSound' type='user' func='edit' ot='album'}" title="{$createTitle}" class="z-icon-es-add">{$createTitle}</a>
        {/checkpermissionblock}
    {/if}
    {assign var='own' value=0}
    {if isset($showOwnEntries) && $showOwnEntries eq 1}
        {assign var='own' value=1}
    {/if}
    {assign var='all' value=0}
    {if isset($showAllEntries) && $showAllEntries eq 1}
        {gt text='Back to paginated view' assign='linkTitle'}
        <a href="{modurl modname='MUSound' type='user' func='view' ot='album'}" title="{$linkTitle}" class="z-icon-es-view">
            {$linkTitle}
        </a>
        {assign var='all' value=1}
    {else}
        {gt text='Show all entries' assign='linkTitle'}
        <a href="{modurl modname='MUSound' type='user' func='view' ot='album' all=1}" title="{$linkTitle}" class="z-icon-es-view">{$linkTitle}</a>
    {/if}

    {include file='user/album/view_quickNav.tpl' all=$all own=$own}{* see template file for available options *}

    <table class="z-datatable">
        <colgroup>
           {* <col id="cWorkflowState" /> *}
            <col id="cTitle" />
           {* <col id="cDescription" /> *}
            <col id="cAuthor" />
           {* <col id="cUploadCover" />
            <col id="cPublishedDate" />
            <col id="cPublishedText" /> *}
            <col id="cCollection" />
            <col id="cItemActions" />
        </colgroup>
        <thead>
        <tr>
            {assign var='catIdListMainString' value=','|implode:$catIdList.Main}
           {* <th id="hWorkflowState" scope="col" class="z-left">
                {sortlink __linktext='State' currentsort=$sort modname='MUSound' type='user' func='view' ot='album' sort='workflowState' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString collection=$collection workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
            </th> *}
            <th id="hTitle" scope="col" class="z-left">
                {sortlink __linktext='Title' currentsort=$sort modname='MUSound' type='user' func='view' ot='album' sort='title' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString collection=$collection workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
            </th>
           {* <th id="hDescription" scope="col" class="z-left">
                {sortlink __linktext='Description' currentsort=$sort modname='MUSound' type='user' func='view' ot='album' sort='description' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString collection=$collection workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
            </th> *}
            <th id="hAuthor" scope="col" class="z-left">
                {sortlink __linktext='Author' currentsort=$sort modname='MUSound' type='user' func='view' ot='album' sort='author' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString collection=$collection workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
            </th>
           {* <th id="hUploadCover" scope="col" class="z-left">
                {sortlink __linktext='Upload cover' currentsort=$sort modname='MUSound' type='user' func='view' ot='album' sort='uploadCover' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString collection=$collection workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
            </th>
            <th id="hPublishedDate" scope="col" class="z-left">
                {sortlink __linktext='Published date' currentsort=$sort modname='MUSound' type='user' func='view' ot='album' sort='publishedDate' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString collection=$collection workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
            </th>
            <th id="hPublishedText" scope="col" class="z-left">
                {sortlink __linktext='Published text' currentsort=$sort modname='MUSound' type='user' func='view' ot='album' sort='publishedText' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString collection=$collection workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
            </th> *}
            <th id="hCollection" scope="col" class="z-left">
                {sortlink __linktext='Collection' currentsort=$sort modname='MUSound' type='user' func='view' ot='album' sort='collection' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString collection=$collection workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
            </th> 
            <th id="hItemActions" scope="col" class="z-right z-order-unsorted">{gt text='Actions'}</th>
        </tr>
        </thead>
        <tbody>
    
    {foreach item='album' from=$items}
        <tr class="{cycle values='z-odd, z-even'}">
           {* <td headers="hWorkflowState" class="z-left z-nowrap">
                {$album.workflowState|musoundObjectState}
            </td> *}
            <td headers="hTitle" class="z-left">
                <a href="{modurl modname='MUSound' type='user' func='display' ot='album' id=$album.id}" title="{gt text='View detail page'}">{$album.title|notifyfilters:'musound.filterhook.albums'}</a>
            </td>
           {* <td headers="hDescription" class="z-left">
                {$album.description}
            </td> *}
            <td headers="hAuthor" class="z-left">
                {$album.author}
            </td>
           {* <td headers="hUploadCover" class="z-left">
                {if $album.uploadCover ne ''}
                  <a href="{$album.uploadCoverFullPathURL}" title="{$album->getTitleFromDisplayPattern()|replace:"\"":""}"{if $album.uploadCoverMeta.isImage} rel="imageviewer[album]"{/if}>
                  {if $album.uploadCoverMeta.isImage}
                      {thumb image=$album.uploadCoverFullPath objectid="album-`$album.id`" preset=$albumThumbPresetUploadCover tag=true img_alt=$album->getTitleFromDisplayPattern()}
                  {else}
                      {gt text='Download'} ({$album.uploadCoverMeta.size|musoundGetFileSize:$album.uploadCoverFullPath:false:false})
                  {/if}
                  </a>
                {else}&nbsp;{/if}
            </td>
            <td headers="hPublishedDate" class="z-left">
                {$album.publishedDate|dateformat:'datetimebrief'}
            </td>
            <td headers="hPublishedText" class="z-left">
                {$album.publishedText}
            </td> *}
            <td headers="hCollection" class="z-left">
                {if isset($album.Collection) && $album.Collection ne null}
                    <a href="{modurl modname='MUSound' type='user' func='display' ot='collection' id=$album.Collection.id}">{strip}
                      {$album.Collection->getTitleFromDisplayPattern()|default:""}
                    {/strip}</a>
                    <a id="collectionItem{$album.id}_rel_{$album.Collection.id}Display" href="{modurl modname='MUSound' type='user' func='display' ot='collection' id=$album.Collection.id theme='Printer' forcelongurl=true}" title="{gt text='Open quick view window'}" class="z-hide">{icon type='view' size='extrasmall' __alt='Quick view'}</a>
                    <script type="text/javascript">
                    /* <![CDATA[ */
                        document.observe('dom:loaded', function() {
                            musoundInitInlineWindow($('collectionItem{{$album.id}}_rel_{{$album.Collection.id}}Display'), '{{$album.Collection->getTitleFromDisplayPattern()|replace:"'":""}}');
                        });
                    /* ]]> */
                    </script>
                {else}
                    {gt text='Not set.'}
                {/if}
            </td>
            <td id="itemActions{$album.id}" headers="hItemActions" class="z-right z-nowrap z-w02">
                {if count($album._actions) gt 0}
                    {foreach item='option' from=$album._actions}
                        <a href="{$option.url.type|musoundActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}"{if $option.icon eq 'preview'} target="_blank"{/if}>{icon type=$option.icon size='extrasmall' alt=$option.linkText|safetext}</a>
                    {/foreach}
                    {icon id="itemActions`$album.id`Trigger" type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}
                    <script type="text/javascript">
                    /* <![CDATA[ */
                        document.observe('dom:loaded', function() {
                            musoundInitItemActions('album', 'view', 'itemActions{{$album.id}}');
                        });
                    /* ]]> */
                    </script>
                {/if}
            </td>
        </tr>
    {foreachelse}
        <tr class="z-datatableempty">
          <td class="z-left" colspan="4">
        {gt text='No albums found.'}
          </td>
        </tr>
    {/foreach}
    
        </tbody>
    </table>
    
    {if !isset($showAllEntries) || $showAllEntries ne 1}
        {pager rowcount=$pager.numitems limit=$pager.itemsperpage display='page' modname='MUSound' type='user' func='view' ot='album'}
    {/if}

    
    {notifydisplayhooks eventname='musound.ui_hooks.albums.display_view' urlobject=$currentUrlObject assign='hooks'}
    {foreach key='providerArea' item='hook' from=$hooks}
        {$hook}
    {/foreach}
</div>
{include file='user/footer.tpl'}
