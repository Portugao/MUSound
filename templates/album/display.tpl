{* purpose of this template: albums display view *}
{assign var='lct' value='user'}
{if isset($smarty.get.lct) && $smarty.get.lct eq 'admin'}
    {assign var='lct' value='admin'}
{/if}
{include file="`$lct`/header.tpl"}
<div class="musound-album musound-display with-rightbox">
    {gt text='Album' assign='templateTitle'}
    {assign var='templateTitle' value=$album->getTitleFromDisplayPattern()|default:$templateTitle}
    {pagesetvar name='title' value=$templateTitle|@html_entity_decode}
    {if $lct eq 'admin'}
        <div class="z-admin-content-pagetitle">
            {icon type='display' size='small' __alt='Details'}
            <h3>{$templateTitle|notifyfilters:'musound.filter_hooks.albums.filter'} <small>({$album.workflowState|musoundObjectState:false|lower})</small>{icon id="itemActions`$album.id`Trigger" type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}
            </h3>
        </div>
    {else}
        <h2>{$templateTitle|notifyfilters:'musound.filter_hooks.albums.filter'} <small>({$album.workflowState|musoundObjectState:false|lower})</small>{icon id="itemActions`$album.id`Trigger" type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}
        </h2>
    {/if}

    {if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
        <div class="musound-rightbox">
            {if $lct eq 'admin'}
                <h4>{gt text='Tracks'}</h4>
            {else}
                <h3>{gt text='Tracks'}</h3>
            {/if}
            
            {if isset($album.track) && $album.track ne null}
                {include file='track/includeDisplayItemListMany.tpl' items=$album.track}
            {/if}
            
            {assign var='permLevel' value='ACCESS_COMMENT'}
            {if $lct eq 'admin'}
                {assign var='permLevel' value='ACCESS_ADMIN'}
            {/if}
            {checkpermission component='MUSound:Album:' instance='`$album.id`::' level=$permLevel assign='mayManage'}
            {if $mayManage || (isset($uid) && isset($album.createdUserId) && $album.createdUserId eq $uid)}
            <p class="managelink">
                {gt text='Create track' assign='createTitle'}
                <a href="{modurl modname='MUSound' type=$lct func='edit' ot='track' album="`$album.id`" returnTo="`$lct`DisplayAlbum"'}" title="{$createTitle}" class="z-icon-es-add">{$createTitle}</a>
            </p>
            {/if}
        </div>
    {/if}

    <dl>
        <dt>{gt text='State'}</dt>
        <dd>{$album.workflowState|musoundGetListEntry:'album':'workflowState'|safetext}</dd>
        <dt>{gt text='Title'}</dt>
        <dd>{$album.title}</dd>
        <dt>{gt text='Description'}</dt>
        <dd>{$album.description}</dd>
        <dt>{gt text='Author'}</dt>
        <dd>{$album.author}</dd>
        <dt>{gt text='Upload cover'}</dt>
        <dd>{if $album.uploadCover ne ''}
        <a href="{$album.uploadCoverFullPathURL}" title="{$album->getTitleFromDisplayPattern()|replace:"\"":""}"{if $album.uploadCoverMeta.isImage} rel="imageviewer[album]"{/if}>
        {if $album.uploadCoverMeta.isImage}
            {thumb image=$album.uploadCoverFullPath objectid="album-`$album.id`" preset=$albumThumbPresetUploadCover tag=true img_alt=$album->getTitleFromDisplayPattern()}
        {else}
            {gt text='Download'} ({$album.uploadCoverMeta.size|musoundGetFileSize:$album.uploadCoverFullPath:false:false})
        {/if}
        </a>
        {else}&nbsp;{/if}
        </dd>
        <dt>{gt text='Published date'}</dt>
        <dd>{$album.publishedDate|dateformat:'datetimebrief'}</dd>
        <dt>{gt text='Published text'}</dt>
        <dd>{$album.publishedText}</dd>
        <dt>{gt text='Collection'}</dt>
        <dd>
        {if isset($album.collection) && $album.collection ne null}
          {if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
          <a href="{modurl modname='MUSound' type=$lct func='display' ot='collection'  id=$album.collection.id}">{strip}
            {$album.collection->getTitleFromDisplayPattern()}
          {/strip}</a>
          <a id="collectionItem{$album.collection.id}Display" href="{modurl modname='MUSound' type=$lct func='display' ot='collection'  id=$album.collection.id theme='Printer' forcelongurl=true}" title="{gt text='Open quick view window'}" class="z-hide">{icon type='view' size='extrasmall' __alt='Quick view'}</a>
          <script type="text/javascript">
          /* <![CDATA[ */
              document.observe('dom:loaded', function() {
                  mUMUSoundInitInlineWindow($('collectionItem{{$album.collection.id}}Display'), '{{$album.collection->getTitleFromDisplayPattern()|replace:"'":""}}');
              });
          /* ]]> */
          </script>
          {else}
            {$album.collection->getTitleFromDisplayPattern()}
          {/if}
        {else}
            {gt text='Not set.'}
        {/if}
        </dd>
        
    </dl>
    {include file='helper/includeCategoriesDisplay.tpl' obj=$album}
    {include file='helper/includeStandardFieldsDisplay.tpl' obj=$album}

    {if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
        {* include display hooks *}
        {notifydisplayhooks eventname='musound.ui_hooks.albums.display_view' id=$album.id urlobject=$currentUrlObject assign='hooks'}
        {foreach name='hookLoop' key='providerArea' item='hook' from=$hooks}
            {if $providerArea ne 'provider.scribite.ui_hooks.editor'}{* fix for #664 *}
                {$hook}
            {/if}
        {/foreach}
        {if count($album._actions) gt 0}
            <p id="itemActions{$album.id}">
                {foreach item='option' from=$album._actions}
                    <a href="{$option.url.type|musoundActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}" class="z-icon-es-{$option.icon}">{$option.linkText|safetext}</a>
                {/foreach}
            </p>
            <script type="text/javascript">
            /* <![CDATA[ */
                document.observe('dom:loaded', function() {
                    mUMUSoundInitItemActions('album', 'display', 'itemActions{{$album.id}}');
                });
            /* ]]> */
            </script>
        {/if}
        <br style="clear: right" />
    {/if}
</div>
{include file="`$lct`/footer.tpl"}
