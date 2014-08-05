{* purpose of this template: tracks list view *}
{assign var='lct' value='user'}
{if isset($smarty.get.lct) && $smarty.get.lct eq 'admin'}
    {assign var='lct' value='admin'}
{/if}
{include file="`$lct`/header.tpl"}
<div class="musound-track musound-view">
    {gt text='Track list' assign='templateTitle'}
    {pagesetvar name='title' value=$templateTitle}
    {if $lct eq 'admin'}
        <div class="z-admin-content-pagetitle">
            {icon type='view' size='small' alt=$templateTitle}
            <h3>{$templateTitle}</h3>
        </div>
    {else}
        <h2>{$templateTitle}</h2>
    {/if}

    {if $canBeCreated}
        {checkpermissionblock component='MUSound:Track:' instance='::' level='ACCESS_EDIT'}
            {gt text='Create track' assign='createTitle'}
            <a href="{modurl modname='MUSound' type=$lct func='edit' ot='track'}" title="{$createTitle}" class="z-icon-es-add">{$createTitle}</a>
        {/checkpermissionblock}
    {/if}
    {assign var='own' value=0}
    {if isset($showOwnEntries) && $showOwnEntries eq 1}
        {assign var='own' value=1}
    {/if}
    {assign var='all' value=0}
    {if isset($showAllEntries) && $showAllEntries eq 1}
        {gt text='Back to paginated view' assign='linkTitle'}
        <a href="{modurl modname='MUSound' type=$lct func='view' ot='track'}" title="{$linkTitle}" class="z-icon-es-view">{$linkTitle}</a>
        {assign var='all' value=1}
    {else}
        {gt text='Show all entries' assign='linkTitle'}
        <a href="{modurl modname='MUSound' type=$lct func='view' ot='track' all=1}" title="{$linkTitle}" class="z-icon-es-view">{$linkTitle}</a>
    {/if}

    {include file='track/view_quickNav.tpl' all=$all own=$own workflowStateFilter=false}{* see template file for available options *}

    {if $lct eq 'admin'}
    <form action="{modurl modname='MUSound' type='track' func='handleSelectedEntries' lct=$lct}" method="post" id="tracksViewForm" class="z-form">
        <div>
            <input type="hidden" name="csrftoken" value="{insert name='csrftoken'}" />
    {/if}
        <table class="z-datatable">
            <colgroup>
                {if $lct eq 'admin'}
                    <col id="cSelect" />
                {/if}
                <col id="cTitle" />
                <col id="cDescription" />
                <col id="cAuthor" />
                <col id="cUploadTrack" />
                <col id="cUploadZip" />
                <col id="cAlbum" />
                <col id="cItemActions" />
            </colgroup>
            <thead>
            <tr>
                {if $lct eq 'admin'}
                    <th id="hSelect" scope="col" align="center" valign="middle">
                        <input type="checkbox" id="toggleTracks" />
                    </th>
                {/if}
                <th id="hTitle" scope="col" class="z-left">
                    {sortlink __linktext='Title' currentsort=$sort modname='MUSound' type=$lct func='view' sort='title' sortdir=$sdir all=$all own=$own album=$album workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize ot='track'}
                </th>
                <th id="hDescription" scope="col" class="z-left">
                    {sortlink __linktext='Description' currentsort=$sort modname='MUSound' type=$lct func='view' sort='description' sortdir=$sdir all=$all own=$own album=$album workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize ot='track'}
                </th>
                <th id="hAuthor" scope="col" class="z-left">
                    {sortlink __linktext='Author' currentsort=$sort modname='MUSound' type=$lct func='view' sort='author' sortdir=$sdir all=$all own=$own album=$album workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize ot='track'}
                </th>
                <th id="hUploadTrack" scope="col" class="z-left">
                    {sortlink __linktext='Upload track' currentsort=$sort modname='MUSound' type=$lct func='view' sort='uploadTrack' sortdir=$sdir all=$all own=$own album=$album workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize ot='track'}
                </th>
                <th id="hUploadZip" scope="col" class="z-left">
                    {sortlink __linktext='Upload zip' currentsort=$sort modname='MUSound' type=$lct func='view' sort='uploadZip' sortdir=$sdir all=$all own=$own album=$album workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize ot='track'}
                </th>
                <th id="hAlbum" scope="col" class="z-left">
                    {sortlink __linktext='Album' currentsort=$sort modname='MUSound' type=$lct func='view' sort='album' sortdir=$sdir all=$all own=$own album=$album workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize ot='track'}
                </th>
                <th id="hItemActions" scope="col" class="z-right z-order-unsorted">{gt text='Actions'}</th>
            </tr>
            </thead>
            <tbody>
        
        {foreach item='track' from=$items}
            <tr class="{cycle values='z-odd, z-even'}">
                {if $lct eq 'admin'}
                    <td headers="hselect" align="center" valign="top">
                        <input type="checkbox" name="items[]" value="{$track.id}" class="tracks-checkbox" />
                    </td>
                {/if}
                <td headers="hTitle" class="z-left">
                    <a href="{modurl modname='MUSound' type=$lct func='display' ot='track'  id=$track.id}" title="{gt text='View detail page'}">{$track.title|notifyfilters:'musound.filterhook.tracks'}</a>
                </td>
                <td headers="hDescription" class="z-left">
                    {$track.description}
                </td>
                <td headers="hAuthor" class="z-left">
                    {$track.author}
                </td>
                <td headers="hUploadTrack" class="z-left">
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
                </td>
                <td headers="hAlbum" class="z-left">
                    {if isset($track.Album) && $track.Album ne null}
                        <a href="{modurl modname='MUSound' type=$lct func='display' ot='album'  id=$track.Album.id}">{strip}
                          {$track.Album->getTitleFromDisplayPattern()|default:""}
                        {/strip}</a>
                        <a id="albumItem{$track.id}_rel_{$track.Album.id}Display" href="{modurl modname='MUSound' type=$lct func='display' ot='album'  id=$track.Album.id theme='Printer' forcelongurl=true}" title="{gt text='Open quick view window'}" class="z-hide">{icon type='view' size='extrasmall' __alt='Quick view'}</a>
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
                        {icon id="itemActions`$track.id`Trigger" type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}
                        {foreach item='option' from=$track._actions}
                            <a href="{$option.url.type|musoundActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}"{if $option.icon eq 'preview'} target="_blank"{/if}>{icon type=$option.icon size='extrasmall' alt=$option.linkText|safetext}</a>
                        {/foreach}
                    
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
            <tr class="z-{if $lct eq 'admin'}admin{else}data{/if}tableempty">
              <td class="z-left" colspan="{if $lct eq 'admin'}8{else}7{/if}">
            {gt text='No tracks found.'}
              </td>
            </tr>
        {/foreach}
        
            </tbody>
        </table>
        
        {if !isset($showAllEntries) || $showAllEntries ne 1}
            {pager rowcount=$pager.numitems limit=$pager.itemsperpage display='page' modname='MUSound' type='track' func='view' lct=$lct}
        {/if}
    {if $lct eq 'admin'}
            <fieldset>
                <label for="mUSoundAction">{gt text='With selected tracks'}</label>
                <select id="mUSoundAction" name="action">
                    <option value="">{gt text='Choose action'}</option>
                    <option value="delete" title="{gt text='Delete content permanently.'}">{gt text='Delete'}</option>
                </select>
                <input type="submit" value="{gt text='Submit'}" />
            </fieldset>
        </div>
    </form>
    {/if}

    
    {if $lct ne 'admin'}
        {notifydisplayhooks eventname='musound.ui_hooks.tracks.display_view' urlobject=$currentUrlObject assign='hooks'}
        {foreach key='providerArea' item='hook' from=$hooks}
            {$hook}
        {/foreach}
    {/if}
</div>
{include file="`$lct`/footer.tpl"}

<script type="text/javascript">
/* <![CDATA[ */
    document.observe('dom:loaded', function() {
        {{if $lct eq 'admin'}}
            {{* init the "toggle all" functionality *}}
            if ($('toggleTracks') != undefined) {
                $('toggleTracks').observe('click', function (e) {
                    Zikula.toggleInput('tracksViewForm');
                    e.stop()
                });
            }
        {{/if}}
    });
/* ]]> */
</script>
