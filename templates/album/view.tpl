{* purpose of this template: albums list view *}
{assign var='lct' value='user'}
{if isset($smarty.get.lct) && $smarty.get.lct eq 'admin'}
    {assign var='lct' value='admin'}
{/if}
{include file="`$lct`/header.tpl"}
<div class="musound-album musound-view">
    {gt text='Album list' assign='templateTitle'}
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
        {checkpermissionblock component='MUSound:Album:' instance='::' level='ACCESS_COMMENT'}
            {gt text='Create album' assign='createTitle'}
            <a href="{modurl modname='MUSound' type=$lct func='edit' ot='album'}" title="{$createTitle}" class="z-icon-es-add">{$createTitle}</a>
        {/checkpermissionblock}
    {/if}
    {assign var='own' value=0}
    {if isset($showOwnEntries) && $showOwnEntries eq 1}
        {assign var='own' value=1}
    {/if}
    {assign var='all' value=0}
    {if isset($showAllEntries) && $showAllEntries eq 1}
        {gt text='Back to paginated view' assign='linkTitle'}
        <a href="{modurl modname='MUSound' type=$lct func='view' ot='album'}" title="{$linkTitle}" class="z-icon-es-view">{$linkTitle}</a>
        {assign var='all' value=1}
    {else}
        {gt text='Show all entries' assign='linkTitle'}
        <a href="{modurl modname='MUSound' type=$lct func='view' ot='album' all=1}" title="{$linkTitle}" class="z-icon-es-view">{$linkTitle}</a>
    {/if}

    {include file='album/viewQuickNav.tpl' all=$all own=$own}{* see template file for available options *}

    {if $lct eq 'admin'}
    <form action="{modurl modname='MUSound' type='album' func='handleSelectedEntries' lct=$lct}" method="post" id="albumsViewForm" class="z-form">
        <div>
            <input type="hidden" name="csrftoken" value="{insert name='csrftoken'}" />
    {/if}
        <table class="z-datatable">
            <colgroup>
                {if $lct eq 'admin'}
                    <col id="cSelect" />
                    <col id="cWorkflowState" />
                {/if}
                <col id="cTitle" />
                {if $lct eq 'admin'}
                <col id="cDescription" />
                <col id="cAuthor" />
                <col id="cUploadCover" />
                <col id="cPublishedDate" />
                <col id="cPublishedText" />
                {/if}
                <col id="cCollection" />
                <col id="cItemActions" />
            </colgroup>
            <thead>
            <tr>
                {assign var='catIdListMainString' value=','|implode:$catIdList.Main}
                {if $lct eq 'admin'}
                    <th id="hSelect" scope="col" align="center" valign="middle">
                        <input type="checkbox" id="toggleAlbums" />
                    </th>
                    <th id="hWorkflowState" scope="col" class="z-left">
                        {sortlink __linktext='State' currentsort=$sort modname='MUSound' type=$lct func='view' sort='workflowState' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString collection=$collection workflowState=$workflowState q=$q pageSize=$pageSize ot='album'}
                    </th>
               {/if}
                <th id="hTitle" scope="col" class="z-left">
                    {sortlink __linktext='Title' currentsort=$sort modname='MUSound' type=$lct func='view' sort='title' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString collection=$collection workflowState=$workflowState q=$q pageSize=$pageSize ot='album'}
                </th>
                {if $lct eq 'admin'}
                <th id="hDescription" scope="col" class="z-left">
                    {sortlink __linktext='Description' currentsort=$sort modname='MUSound' type=$lct func='view' sort='description' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString collection=$collection workflowState=$workflowState q=$q pageSize=$pageSize ot='album'}
                </th>
                <th id="hAuthor" scope="col" class="z-left">
                    {sortlink __linktext='Author' currentsort=$sort modname='MUSound' type=$lct func='view' sort='author' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString collection=$collection workflowState=$workflowState q=$q pageSize=$pageSize ot='album'}
                </th>
                <th id="hUploadCover" scope="col" class="z-left">
                    {sortlink __linktext='Upload cover' currentsort=$sort modname='MUSound' type=$lct func='view' sort='uploadCover' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString collection=$collection workflowState=$workflowState q=$q pageSize=$pageSize ot='album'}
                </th>
                <th id="hPublishedDate" scope="col" class="z-left">
                    {sortlink __linktext='Published date' currentsort=$sort modname='MUSound' type=$lct func='view' sort='publishedDate' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString collection=$collection workflowState=$workflowState q=$q pageSize=$pageSize ot='album'}
                </th>
                <th id="hPublishedText" scope="col" class="z-left">
                    {sortlink __linktext='Published text' currentsort=$sort modname='MUSound' type=$lct func='view' sort='publishedText' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString collection=$collection workflowState=$workflowState q=$q pageSize=$pageSize ot='album'}
                </th>
                {/if}
                <th id="hCollection" scope="col" class="z-left">
                    {sortlink __linktext='Collection' currentsort=$sort modname='MUSound' type=$lct func='view' sort='collection' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString collection=$collection workflowState=$workflowState q=$q pageSize=$pageSize ot='album'}
                </th>
                <th id="hItemActions" scope="col" class="z-right z-order-unsorted">{gt text='Actions'}</th>
            </tr>
            </thead>
            <tbody>
        
        {foreach item='album' from=$items}
            <tr class="{cycle values='z-odd, z-even'}">
                {if $lct eq 'admin'}
                    <td headers="hSelect" align="center" valign="top">
                        <input type="checkbox" name="items[]" value="{$album.id}" class="albums-checkbox" />
                    </td>     
                <td headers="hWorkflowState" class="z-left z-nowrap">
                    {$album.workflowState|musoundObjectState}
                </td>
                {/if}
                <td headers="hTitle" class="z-left">
                    <a href="{modurl modname='MUSound' type=$lct func='display' ot='album'  id=$album.id}" title="{gt text='View detail page'}">{$album.title|notifyfilters:'musound.filterhook.albums'}</a>
                </td>
                {if $lct eq 'admin'}
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
                </td>{/if}
                <td headers="hCollection" class="z-left">
                    {if isset($album.collection) && $album.collection ne null}
                        <a href="{modurl modname='MUSound' type=$lct func='display' ot='collection'  id=$album.collection.id}">{strip}
                          {$album.collection->getTitleFromDisplayPattern()}
                        {/strip}</a>
                        <a id="collectionItem{$album.id}_rel_{$album.collection.id}Display" href="{modurl modname='MUSound' type=$lct func='display' ot='collection'  id=$album.collection.id theme='Printer' forcelongurl=true}" title="{gt text='Open quick view window'}" class="z-hide">{icon type='view' size='extrasmall' __alt='Quick view'}</a>
                        <script type="text/javascript">
                        /* <![CDATA[ */
                            document.observe('dom:loaded', function() {
                                mUMUSoundInitInlineWindow($('collectionItem{{$album.id}}_rel_{{$album.collection.id}}Display'), '{{$album.collection->getTitleFromDisplayPattern()|replace:"'":""}}');
                            });
                        /* ]]> */
                        </script>
                    {else}
                        {gt text='Not set.'}
                    {/if}
                </td>
                
                <td id="itemActions{$album.id}" headers="hItemActions" class="z-right z-nowrap z-w02">
                    {if count($album._actions) gt 0}
                        {icon id="itemActions`$album.id`Trigger" type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}
                        {foreach item='option' from=$album._actions}
                            <a href="{$option.url.type|musoundActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}"{if $option.icon eq 'preview'} target="_blank"{/if}>{icon type=$option.icon size='extrasmall' alt=$option.linkText|safetext}</a>
                        {/foreach}
                        <script type="text/javascript">
                        /* <![CDATA[ */
                            document.observe('dom:loaded', function() {
                                mUMUSoundInitItemActions('album', 'view', 'itemActions{{$album.id}}');
                            });
                        /* ]]> */
                        </script>
                    {/if}
                </td>
            </tr>
        {foreachelse}
            <tr class="z-{if $lct eq 'admin'}admin{else}data{/if}tableempty">
                <td class="z-left" colspan="{if $lct eq 'admin'}10{else}3{/if}">
            {gt text='No albums found.'}
              </td>
            </tr>
        {/foreach}
        
            </tbody>
        </table>
        
        {if !isset($showAllEntries) || $showAllEntries ne 1}
            {pager rowcount=$pager.numitems limit=$pager.itemsperpage display='page' modname='MUSound' type=$lct func='view' ot='album'}
        {/if}
    {if $lct eq 'admin'}
            <fieldset>
                <label for="mUSoundAction">{gt text='With selected albums'}</label>
                <select id="mUSoundAction" name="action">
                    <option value="">{gt text='Choose action'}</option>
                <option value="approve" title="{gt text='Update content and approve for immediate publishing.'}">{gt text='Approve'}</option>
                    <option value="delete" title="{gt text='Delete content permanently.'}">{gt text='Delete'}</option>
                </select>
                <input type="submit" value="{gt text='Submit'}" />
            </fieldset>
        </div>
    </form>
    {/if}

    
    {* here you can activate calling display hooks for the view page if you need it *}
    {*if $lct ne 'admin'}
        {notifydisplayhooks eventname='musound.ui_hooks.albums.display_view' urlobject=$currentUrlObject assign='hooks'}
        {foreach key='providerArea' item='hook' from=$hooks}
            {$hook}
        {/foreach}
    {/if*}
</div>
{include file="`$lct`/footer.tpl"}

<script type="text/javascript">
/* <![CDATA[ */
    document.observe('dom:loaded', function() {
        {{if $lct eq 'admin'}}
            {{* init the "toggle all" functionality *}}
            if ($('toggleAlbums') != undefined) {
                $('toggleAlbums').observe('click', function (e) {
                    Zikula.toggleInput('albumsViewForm');
                    e.stop();
                });
            }
        {{/if}}
    });
/* ]]> */
</script>
