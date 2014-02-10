{* purpose of this template: albums view view in admin area *}
{include file='admin/header.tpl'}
<div class="musound-album musound-view">
    {gt text='Album list' assign='templateTitle'}
    {pagesetvar name='title' value=$templateTitle}
    <div class="z-admin-content-pagetitle">
        {icon type='view' size='small' alt=$templateTitle}
        <h3>{$templateTitle}</h3>
    </div>

    {if $canBeCreated}
        {checkpermissionblock component='MUSound:Album:' instance='::' level='ACCESS_COMMENT'}
            {gt text='Create album' assign='createTitle'}
            <a href="{modurl modname='MUSound' type='admin' func='edit' ot='album'}" title="{$createTitle}" class="z-icon-es-add">{$createTitle}</a>
        {/checkpermissionblock}
    {/if}
    {assign var='own' value=0}
    {if isset($showOwnEntries) && $showOwnEntries eq 1}
        {assign var='own' value=1}
    {/if}
    {assign var='all' value=0}
    {if isset($showAllEntries) && $showAllEntries eq 1}
        {gt text='Back to paginated view' assign='linkTitle'}
        <a href="{modurl modname='MUSound' type='admin' func='view' ot='album'}" title="{$linkTitle}" class="z-icon-es-view">
            {$linkTitle}
        </a>
        {assign var='all' value=1}
    {else}
        {gt text='Show all entries' assign='linkTitle'}
        <a href="{modurl modname='MUSound' type='admin' func='view' ot='album' all=1}" title="{$linkTitle}" class="z-icon-es-view">{$linkTitle}</a>
    {/if}

    {include file='admin/album/view_quickNav.tpl' all=$all own=$own}{* see template file for available options *}

    <form action="{modurl modname='MUSound' type='admin' func='handleSelectedEntries'}" method="post" id="albumsViewForm" class="z-form">
        <div>
            <input type="hidden" name="csrftoken" value="{insert name='csrftoken'}" />
            <input type="hidden" name="ot" value="album" />
            <table class="z-datatable">
                <colgroup>
                    <col id="cSelect" />
                    <col id="cWorkflowState" />
                    <col id="cTitle" />
                    <col id="cDescription" />
                    <col id="cAuthor" />
                    <col id="cUploadCover" />
                    <col id="cPublishedDate" />
                    <col id="cPublishedText" />
                    <col id="cItemActions" />
                </colgroup>
                <thead>
                <tr>
                    {assign var='catIdListMainString' value=','|implode:$catIdList.Main}
                    <th id="hSelect" scope="col" align="center" valign="middle">
                        <input type="checkbox" id="toggleAlbums" />
                    </th>
                    <th id="hWorkflowState" scope="col" class="z-left">
                        {sortlink __linktext='State' currentsort=$sort modname='MUSound' type='admin' func='view' ot='album' sort='workflowState' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
                    </th>
                    <th id="hTitle" scope="col" class="z-left">
                        {sortlink __linktext='Title' currentsort=$sort modname='MUSound' type='admin' func='view' ot='album' sort='title' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
                    </th>
                    <th id="hDescription" scope="col" class="z-left">
                        {sortlink __linktext='Description' currentsort=$sort modname='MUSound' type='admin' func='view' ot='album' sort='description' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
                    </th>
                    <th id="hAuthor" scope="col" class="z-left">
                        {sortlink __linktext='Author' currentsort=$sort modname='MUSound' type='admin' func='view' ot='album' sort='author' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
                    </th>
                    <th id="hUploadCover" scope="col" class="z-left">
                        {sortlink __linktext='Upload cover' currentsort=$sort modname='MUSound' type='admin' func='view' ot='album' sort='uploadCover' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
                    </th>
                    <th id="hPublishedDate" scope="col" class="z-left">
                        {sortlink __linktext='Published date' currentsort=$sort modname='MUSound' type='admin' func='view' ot='album' sort='publishedDate' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
                    </th>
                    <th id="hPublishedText" scope="col" class="z-left">
                        {sortlink __linktext='Published text' currentsort=$sort modname='MUSound' type='admin' func='view' ot='album' sort='publishedText' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
                    </th>
                    <th id="hItemActions" scope="col" class="z-right z-order-unsorted">{gt text='Actions'}</th>
                </tr>
                </thead>
                <tbody>
            
            {foreach item='album' from=$items}
                <tr class="{cycle values='z-odd, z-even'}">
                    <td headers="hselect" align="center" valign="top">
                        <input type="checkbox" name="items[]" value="{$album.id}" class="albums-checkbox" />
                    </td>
                    <td headers="hWorkflowState" class="z-left z-nowrap">
                        {$album.workflowState|musoundObjectState}
                    </td>
                    <td headers="hTitle" class="z-left">
                        <a href="{modurl modname='MUSound' type='admin' func='display' ot='album' id=$album.id}" title="{gt text='View detail page'}">{$album.title|notifyfilters:'musound.filterhook.albums'}</a>
                    </td>
                    <td headers="hDescription" class="z-left">
                        {$album.description}
                    </td>
                    <td headers="hAuthor" class="z-left">
                        {$album.author}
                    </td>
                    <td headers="hUploadCover" class="z-left">
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
                <tr class="z-admintableempty">
                  <td class="z-left" colspan="9">
                {gt text='No albums found.'}
                  </td>
                </tr>
            {/foreach}
            
                </tbody>
            </table>
            
            {if !isset($showAllEntries) || $showAllEntries ne 1}
                {pager rowcount=$pager.numitems limit=$pager.itemsperpage display='page' modname='MUSound' type='admin' func='view' ot='album'}
            {/if}
            <fieldset>
                <label for="mUSoundAction">{gt text='With selected albums'}</label>
                <select id="mUSoundAction" name="action">
                    <option value="">{gt text='Choose action'}</option>
                <option value="approve" title="{gt text='Update content and approve for immediate publishing.'}">{gt text='Approve'}</option>
                <option value="unpublish" title="{gt text='Hide content temporarily.'}">{gt text='Unpublish'}</option>
                <option value="publish" title="{gt text='Make content available again.'}">{gt text='Publish'}</option>
                    <option value="delete" title="{gt text='Delete content permanently.'}">{gt text='Delete'}</option>
                </select>
                <input type="submit" value="{gt text='Submit'}" />
            </fieldset>
        </div>
    </form>

</div>
{include file='admin/footer.tpl'}

<script type="text/javascript">
/* <![CDATA[ */
    document.observe('dom:loaded', function() {
    {{* init the "toggle all" functionality *}}
    if ($('toggleAlbums') != undefined) {
        $('toggleAlbums').observe('click', function (e) {
            Zikula.toggleInput('albumsViewForm');
            e.stop()
        });
    }
    });
/* ]]> */
</script>
