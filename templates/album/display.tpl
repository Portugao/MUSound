{* purpose of this template: albums display view *}
{assign var='lct' value='user'}
{if isset($smarty.get.lct) && $smarty.get.lct eq 'admin'}
    {assign var='lct' value='admin'}
{/if}
{include file="`$lct`/header.tpl"}
{pageaddvar name='javascript' value='jquery'}
{pageaddvar name='javascript' value='jquery-ui'}
{if $coredata.MUSound.useStandard eq true}
{pageaddvar name='javascript' value='modules/MUSound/lib/vendor/musicplayer/jquery-jplayer/jquery.jplayer.js'}
{pageaddvar name='javascript' value='modules/MUSound/lib/vendor/musicplayer/ttw-music-player-min.js'}
{pageaddvar name='stylesheet' value='modules/MUSound/lib/vendor/musicplayer/css/style.css'}
{else}
{pageaddvar name='javascript' value='modules/MUSound/lib/vendor/audiojs/audio.min.js'}
{/if}

<div class="musound-album musound-display with-rightbox">
    {gt text='Album' assign='templateTitle'}
    {assign var='templateTitle' value=$album->getTitleFromDisplayPattern()|default:$templateTitle}
    {pagesetvar name='title' value=$templateTitle|@html_entity_decode}
    <h2>{$templateTitle|notifyfilters:'musound.filter_hooks.albums.filter'} {* <small>({$album.workflowState|musoundObjectState:false|lower})</small> *}{icon id='itemActionsTrigger' type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}</h2>
    {if $coredata.MUSound.useStandard eq false}
    	{if $album.uploadCover ne ''}
          <div><div class="musound-album-cover"><a class="musound-imageviewer" href="{$album.uploadCoverFullPathURL}" title="{$album->getTitleFromDisplayPattern()|replace:"\"":""}"{if $album.uploadCoverMeta.isImage} rel="imageviewer[album]"{/if}>
          {if $album.uploadCoverMeta.isImage}
              {thumb image=$album.uploadCoverFullPath objectid="album-`$album.id`" preset=$albumThumbPresetUploadCover tag=true img_alt=$album->getTitleFromDisplayPattern()}
          {/if}
          </a></div><div class="musound-album-description">{$album.description}</div></div>
        {/if}
    {/if}
    {if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
        <div class="musound-player">
            <h3>{gt text='Tracks'}</h3>
            
            {if isset($album.track) && $album.track ne null}
                {include file='track/include_displayItemListMany.tpl' items=$album.track}
            {/if}
        </div>
    {/if}

    <dl>
       {* <dt>{gt text='State'}</dt>
        <dd>{$album.workflowState|musoundGetListEntry:'album':'workflowState'|safetext}</dd>
        <dt>{gt text='Title'}</dt>
        <dd>{$album.title}</dd>
        <dt>{gt text='Description'}</dt>
        <dd>{$album.description}</dd>
        <dt>{gt text='Cover'}</dt>
        <dd>{if $album.uploadCover ne ''}
          <a href="{$album.uploadCoverFullPathURL}" title="{$album->getTitleFromDisplayPattern()|replace:"\"":""}"{if $album.uploadCoverMeta.isImage} rel="imageviewer[album]"{/if}>
          {if $album.uploadCoverMeta.isImage}
              {thumb image=$album.uploadCoverFullPath objectid="album-`$album.id`" preset=$albumThumbPresetUploadCover tag=true img_alt=$album->getTitleFromDisplayPattern()}
          {else}
              {gt text='Download'} ({$album.uploadCoverMeta.size|musoundGetFileSize:$album.uploadCoverFullPath:false:false})
          {/if}
          </a>
        {else}&nbsp;{/if}
        </dd> *}
        {if $album.publishedText ne '' || $album.publishedDate}
        <dt>{gt text='Published date'}</dt>
        {if $album.publishedText ne NULL}
        <dd>{$album.publishedText}</dd>
        {else}
       <dd>{$album.publishedDate|dateformat:'datetimebrief'}</dd>
        {/if}
        {/if}
        {* <dt>{gt text='Published text'}</dt>
        <dd>{$album.publishedText}</dd>*}
        
        {if isset($album.Collection) && $album.Collection ne null}
            <dt>{gt text='Collection'}</dt> 
        	<dd>
            {if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
                <a href="{modurl modname='MUSound' type='user' func='display' ot='collection' id=$album.Collection.id}">{strip}
                {$album.Collection->getTitleFromDisplayPattern()|default:""}
          {/strip}</a>
          <a id="collectionItem{$album.Collection.id}Display" href="{modurl modname='MUSound' type='user' func='display' ot='collection' id=$album.Collection.id theme='Printer' forcelongurl=true}" title="{gt text='Open quick view window'}" class="z-hide">{icon type='view' size='extrasmall' __alt='Quick view'}</a>
          <script type="text/javascript">
          /* <![CDATA[ */
              document.observe('dom:loaded', function() {
                  musoundInitInlineWindow($('collectionItem{{$album.Collection.id}}Display'), '{{$album.Collection->getTitleFromDisplayPattern()|replace:"'":""}}');
              });
          /* ]]> */
          </script>
          {else}
            {$album.Collection->getTitleFromDisplayPattern()|default:""}
          {/if}
          </dd>
        {else}
            {gt text='Not set.'}
        {/if}
        
        
    </dl>
    {include file='helper/includeCategoriesDisplay.tpl' obj=$album}
    {include file='helper/includeStandardFieldsDisplay.tpl' obj=$album}
    
    {if $coredata.MUSound.useStandard eq false && $lct eq 'user'}
      <div id="shortcuts">
      <div>
        <h1>Keyboard shortcuts:</h1>
        <p><em>&rarr;</em> {gt text='Next track'}</p>
        <p><em>&larr;</em> {gt text='Previous track'}</p>
        <p><em>{gt text='Space'}</em> {gt text='Play/pause'}</p>
      </div>
    </div>
    {/if}

    {if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
        {* include display hooks *}
        {notifydisplayhooks eventname='musound.ui_hooks.albums.display_view' id=$album.id urlobject=$currentUrlObject assign='hooks'}
        {foreach key='providerArea' item='hook' from=$hooks}
            {$hook}
        {/foreach}
        {if count($album._actions) gt 0}
            <p id="itemActions">
            {foreach item='option' from=$album._actions}
                <a href="{$option.url.type|musoundActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}" class="z-icon-es-{$option.icon}">{$option.linkText|safetext}</a>
            {/foreach}
            </p>
            <script type="text/javascript">
            /* <![CDATA[ */
                document.observe('dom:loaded', function() {
                    mUMUSoundInitItemActions('album', 'display', 'itemActions');
                });
            /* ]]> */
            </script>
        {/if}
        <br style="clear: right" />
    {/if}
</div>
{include file='user/footer.tpl'}
