{* purpose of this template: tracks display view *}
{assign var='lct' value='user'}
{if isset($smarty.get.lct) && $smarty.get.lct eq 'admin'}
    {assign var='lct' value='admin'}
{/if}
{include file="`$lct`/header.tpl"}
<div class="musound-track musound-display">
    {gt text='Track' assign='templateTitle'}
    {assign var='templateTitle' value=$track->getTitleFromDisplayPattern()|default:$templateTitle}
    {pagesetvar name='title' value=$templateTitle|@html_entity_decode}
    {if $lct eq 'admin'}
        <div class="z-admin-content-pagetitle">
            {icon type='display' size='small' __alt='Details'}
            <h3>{$templateTitle|notifyfilters:'musound.filter_hooks.tracks.filter'}{icon id="itemActions`$track.id`Trigger" type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}
            </h3>
        </div>
    {else}
        <h2>{$templateTitle|notifyfilters:'musound.filter_hooks.tracks.filter'}{icon id="itemActions`$track.id`Trigger" type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}
        </h2>
    {/if}


    <dl>
        <dt>{gt text='Title'}</dt>
        <dd>{$track.title}</dd>
        <dt>{gt text='Description'}</dt>
        <dd>{$track.description}</dd>
        <dt>{gt text='Author'}</dt>
        <dd>{$track.author}</dd>
        <dt>{gt text='Upload track'}</dt>
        <dd>{if $track.uploadTrack ne ''}
        <a href="{$track.uploadTrackFullPathURL}" title="{$track->getTitleFromDisplayPattern()|replace:"\"":""}"{if $track.uploadTrackMeta.isImage} rel="imageviewer[track]"{/if}>
        {if $track.uploadTrackMeta.isImage}
            {thumb image=$track.uploadTrackFullPath objectid="track-`$track.id`" preset=$trackThumbPresetUploadTrack tag=true img_alt=$track->getTitleFromDisplayPattern()}
        {else}
            {gt text='Download'} ({$track.uploadTrackMeta.size|musoundGetFileSize:$track.uploadTrackFullPath:false:false})
        {/if}
        </a>
        {else}&nbsp;{/if}
        </dd>
        <dt>{gt text='Upload zip'}</dt>
        <dd>{if $track.uploadZip ne ''}
        <a href="{$track.uploadZipFullPathURL}" title="{$track->getTitleFromDisplayPattern()|replace:"\"":""}"{if $track.uploadZipMeta.isImage} rel="imageviewer[track]"{/if}>
        {if $track.uploadZipMeta.isImage}
            {thumb image=$track.uploadZipFullPath objectid="track-`$track.id`" preset=$trackThumbPresetUploadZip tag=true img_alt=$track->getTitleFromDisplayPattern()}
        {else}
            {gt text='Download'} ({$track.uploadZipMeta.size|musoundGetFileSize:$track.uploadZipFullPath:false:false})
        {/if}
        </a>
        {else}&nbsp;{/if}
        </dd>
        <dt>{gt text='Pos'}</dt>
        <dd>{$track.pos}</dd>
        <dt>{gt text='Album'}</dt>
        <dd>
        {if isset($track.album) && $track.album ne null}
          {if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
          <a href="{modurl modname='MUSound' type=$lct func='display' ot='album'  id=$track.album.id}">{strip}
            {$track.album->getTitleFromDisplayPattern()}
          {/strip}</a>
          <a id="albumItem{$track.album.id}Display" href="{modurl modname='MUSound' type=$lct func='display' ot='album'  id=$track.album.id theme='Printer' forcelongurl=true}" title="{gt text='Open quick view window'}" class="z-hide">{icon type='view' size='extrasmall' __alt='Quick view'}</a>
          <script type="text/javascript">
          /* <![CDATA[ */
              document.observe('dom:loaded', function() {
                  mUMUSoundInitInlineWindow($('albumItem{{$track.album.id}}Display'), '{{$track.album->getTitleFromDisplayPattern()|replace:"'":""}}');
              });
          /* ]]> */
          </script>
          {else}
            {$track.album->getTitleFromDisplayPattern()}
          {/if}
        {else}
            {gt text='Not set.'}
        {/if}
        </dd>
        
    </dl>
    <div id="wrapper2"></div>
    {include file='helper/includeStandardFieldsDisplay.tpl' obj=$track}

    {if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
        {* include display hooks *}
        {notifydisplayhooks eventname='musound.ui_hooks.tracks.display_view' id=$track.id urlobject=$currentUrlObject assign='hooks'}
        {foreach name='hookLoop' key='providerArea' item='hook' from=$hooks}
            {if $providerArea ne 'provider.scribite.ui_hooks.editor'}{* fix for #664 *}
                {$hook}
            {/if}
        {/foreach}
        {if count($track._actions) gt 0}
            <p id="itemActions{$track.id}">
                {foreach item='option' from=$track._actions}
                    <a href="{$option.url.type|musoundActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}" class="z-icon-es-{$option.icon}">{$option.linkText|safetext}</a>
                {/foreach}
            </p>
            <script type="text/javascript">
            /* <![CDATA[ */
                document.observe('dom:loaded', function() {
                    mUMUSoundInitItemActions('track', 'display', 'itemActions{{$track.id}}');
                });
            /* ]]> */
            </script>
        {/if}
    {/if}
</div>
{include file="`$lct`/footer.tpl"}
{if $coredata.MUSound.useStandard eq true}
    <script type="text/javascript">
    /* <![CDATA[ */
        var myPlaylist = [
        {
            mp3:'{{$track.uploadTrackFullPathUrl}}',
            title:'{{$track.title}}',
            artist:'{{if $track.author ne ''}}{{$track.author}}{{else}}{{$track.album.author}}{{/if}}',
            cover:'{{$track.album.uploadCoverFullPathUrl}}'
        }
    ];
            var description = '{{$track.album.description}}';
            jQuery('#wrapper2').ttwMusicPlayer(myPlaylist, {
                autoPlay:false, 
                description:description,
                jPlayer:{
                    swfPath:'{{$baseurl}}modules/MUSound/lib/vendor/musicplayer/jquery-jplayer' //You need to override the default swf path any time the directory structure changes
                }
            });
	            
{{*  audiojs.events.ready(function() {
    var as = audiojs.createAll();
  }); *}}
            /* ]]> */
            </script>
{/if}
