{* purpose of this template: tracks view view in user area *}
{include file='user/header.tpl'}
<div class="musound-track musound-view">
    {gt text='Track list' assign='templateTitle'}
    {pagesetvar name='title' value=$templateTitle}
    <h2>{$templateTitle}</h2>

    {if $canBeCreated}
        {checkpermissionblock component='MUSound:Track:' instance='::' level='ACCESS_EDIT'}
            {gt text='Create track' assign='createTitle'}
            <a href="{modurl modname='MUSound' type='user' func='edit' ot='track'}" title="{$createTitle}" class="z-icon-es-add">{$createTitle}</a>
        {/checkpermissionblock}
    {/if}
    {assign var='own' value=0}
    {if isset($showOwnEntries) && $showOwnEntries eq 1}
        {assign var='own' value=1}
    {/if}
    {assign var='all' value=0}
    {if isset($showAllEntries) && $showAllEntries eq 1}
        {gt text='Back to paginated view' assign='linkTitle'}
        <a href="{modurl modname='MUSound' type='user' func='view' ot='track'}" title="{$linkTitle}" class="z-icon-es-view">
            {$linkTitle}
        </a>
        {assign var='all' value=1}
    {else}
        {gt text='Show all entries' assign='linkTitle'}
        <a href="{modurl modname='MUSound' type='user' func='view' ot='track' all=1}" title="{$linkTitle}" class="z-icon-es-view">{$linkTitle}</a>
    {/if}

    {include file='user/track/view_quickNav.tpl' all=$all own=$own workflowStateFilter=false}{* see template file for available options *}

    <table class="z-datatable">
        <colgroup>
            <col id="cTitle" />
           {* <col id="cDescription" /> *}
            <col id="cAuthor" />
           {* <col id="cUploadTrack" />
            <col id="cUploadZip" /> *}
            <col id="cAlbum" />
            <col id="cItemActions" />
        </colgroup>
        <thead>
        <tr>
            <th id="hTitle" scope="col" class="z-left">
                {sortlink __linktext='Title' currentsort=$sort modname='MUSound' type='user' func='view' ot='track' sort='title' sortdir=$sdir all=$all own=$own album=$album workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
            </th>
           {* <th id="hDescription" scope="col" class="z-left">
                {sortlink __linktext='Description' currentsort=$sort modname='MUSound' type='user' func='view' ot='track' sort='description' sortdir=$sdir all=$all own=$own album=$album workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
            </th> *}
            <th id="hAuthor" scope="col" class="z-left">
                {sortlink __linktext='Author' currentsort=$sort modname='MUSound' type='user' func='view' ot='track' sort='author' sortdir=$sdir all=$all own=$own album=$album workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
            </th>
          {*  <th id="hUploadTrack" scope="col" class="z-left">
                {sortlink __linktext='Upload track' currentsort=$sort modname='MUSound' type='user' func='view' ot='track' sort='uploadTrack' sortdir=$sdir all=$all own=$own album=$album workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
            </th>
            <th id="hUploadZip" scope="col" class="z-left">
                {sortlink __linktext='Upload zip' currentsort=$sort modname='MUSound' type='user' func='view' ot='track' sort='uploadZip' sortdir=$sdir all=$all own=$own album=$album workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
            </th> *}
            <th id="hAlbum" scope="col" class="z-left">
                {sortlink __linktext='Album' currentsort=$sort modname='MUSound' type='user' func='view' ot='track' sort='album' sortdir=$sdir all=$all own=$own album=$album workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
            </th>
            <th id="hItemActions" scope="col" class="z-right z-order-unsorted">{gt text='Actions'}</th>
        </tr>
        </thead>
        <tbody>
    
    {foreach item='track' from=$items}
        <tr class="{cycle values='z-odd, z-even'}">
            <td headers="hTitle" class="z-left">
                <a href="{modurl modname='MUSound' type='user' func='display' ot='track' id=$track.id}" title="{gt text='View detail page'}">{$track.title|notifyfilters:'musound.filterhook.tracks'}</a>
            </td>
           {* <td headers="hDescription" class="z-left">
                {$track.description}
            </td> *}
            <td headers="hAuthor" class="z-left">
                {$track.author}
            </td>
           {* <td headers="hUploadTrack" class="z-left">
                {if $track.uploadTrack ne ''}
                  <a href="{$track.uploadTrackFullPathURL}" title="{$track->getTitleFromDisplayPattern()|replace:"\"":""}"{if $track.uploadTrackMeta.isImage} rel="imageviewer[track]"{/if}>
                  {if $track.uploadTrackMeta.isImage}
                      {thumb image=$track.uploadTrackFullPath objectid="track-`$track.id`" preset=$trackThumbPresetUploadTrack tag=true img_alt=$track->getTitleFromDisplayPattern()}
                  {else}
                      {gt text='Download'} ({$track.uploadTrackMeta.size|musoundGetFileSize:$track.uploadTrackFullPath:false:false})
                  {/if}
                  </a>
                {else}&nbsp;{/if}
            </td>
            <td headers="hUploadZip" class="z-left">
                {if $track.uploadZip ne ''}
                  <a href="{$track.uploadZipFullPathURL}" title="{$track->getTitleFromDisplayPattern()|replace:"\"":""}"{if $track.uploadZipMeta.isImage} rel="imageviewer[track]"{/if}>
                  {if $track.uploadZipMeta.isImage}
                      {thumb image=$track.uploadZipFullPath objectid="track-`$track.id`" preset=$trackThumbPresetUploadZip tag=true img_alt=$track->getTitleFromDisplayPattern()}
                  {else}
                      {gt text='Download'} ({$track.uploadZipMeta.size|musoundGetFileSize:$track.uploadZipFullPath:false:false})
                  {/if}
                  </a>
                {else}&nbsp;{/if}
            </td> *}
            <td headers="hAlbum" class="z-left">
                {if isset($track.Album) && $track.Album ne null}
                    <a href="{modurl modname='MUSound' type='user' func='display' ot='album' id=$track.Album.id}">{strip}
                      {$track.Album->getTitleFromDisplayPattern()|default:""}
                    {/strip}</a>
                    <a id="albumItem{$track.id}_rel_{$track.Album.id}Display" href="{modurl modname='MUSound' type='user' func='display' ot='album' id=$track.Album.id theme='Printer' forcelongurl=true}" title="{gt text='Open quick view window'}" class="z-hide">{icon type='view' size='extrasmall' __alt='Quick view'}</a>
                    <script type="text/javascript">
                    /* <![CDATA[ */
                        document.observe('dom:loaded', function() {
                            musoundInitInlineWindow($('albumItem{{$track.id}}_rel_{{$track.Album.id}}Display'), '{{$track.Album->getTitleFromDisplayPattern()|replace:"'":""}}');
                        });
                    /* ]]> */
                    </script>
                {else}
                    {gt text='Not set.'}
                {/if}
            </td>
            <td id="itemActions{$track.id}" headers="hItemActions" class="z-right z-nowrap z-w02">
                {if count($track._actions) gt 0}
                    {foreach item='option' from=$track._actions}
                        <a href="{$option.url.type|musoundActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}"{if $option.icon eq 'preview'} target="_blank"{/if}>{icon type=$option.icon size='extrasmall' alt=$option.linkText|safetext}</a>
                    {/foreach}
                    {icon id="itemActions`$track.id`Trigger" type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}
                    <script type="text/javascript">
                    /* <![CDATA[ */
                        document.observe('dom:loaded', function() {
                            musoundInitItemActions('track', 'view', 'itemActions{{$track.id}}');
                        });
                    /* ]]> */
                    </script>
                {/if}
            </td>
        </tr>
    {foreachelse}
        <tr class="z-datatableempty">
          <td class="z-left" colspan="4">
        {gt text='No tracks found.'}
          </td>
        </tr>
    {/foreach}
    
        </tbody>
    </table>
    
    {if !isset($showAllEntries) || $showAllEntries ne 1}
        {pager rowcount=$pager.numitems limit=$pager.itemsperpage display='page' modname='MUSound' type='user' func='view' ot='track'}
    {/if}

    
    {notifydisplayhooks eventname='musound.ui_hooks.tracks.display_view' urlobject=$currentUrlObject assign='hooks'}
    {foreach key='providerArea' item='hook' from=$hooks}
        {$hook}
    {/foreach}
</div>
{include file='user/footer.tpl'}
