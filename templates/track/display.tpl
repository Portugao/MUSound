{* purpose of this template: tracks display view in user area *}
{include file='user/header.tpl'}
{pageaddvar name='javascript' value='jquery'}
{pageaddvar name='javascript' value='jquery-ui'}
{pageaddvar name='javascript' value='modules/MUSound/lib/vendor/musicplayer/jquery-jplayer/jquery.jplayer.js'}
{pageaddvar name='javascript' value='modules/MUSound/lib/vendor/musicplayer/ttw-music-player-min.js'}
{pageaddvar name='stylesheet' value='modules/MUSound/lib/vendor/musicplayer/css/style.css'}

<div class="musound-track musound-display">
    {gt text='Track' assign='templateTitle'}
    {assign var='templateTitle' value=$track->getTitleFromDisplayPattern()|default:$templateTitle}
    {pagesetvar name='title' value=$templateTitle|@html_entity_decode}
    <h2>{$templateTitle|notifyfilters:'musound.filter_hooks.tracks.filter'}{icon id='itemActionsTrigger' type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}</h2>

    <dl>
      {*  <dt>{gt text='Title'}</dt>
        <dd>{$track.title}</dd> *}
        <dt>{gt text='Description'}</dt>
        <dd>{$track.description}</dd>
        <dt>{gt text='Author'}</dt>
        <dd>{$track.author}</dd>
       {* <dt>{gt text='Upload track'}</dt>
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
        </dd> *}
        <dt>{gt text='Album'}</dt>
        <dd>
        {if isset($track.Album) && $track.Album ne null}
          {if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
          <a href="{modurl modname='MUSound' type='user' func='display' ot='album' id=$track.Album.id}">{strip}
            {$track.Album->getTitleFromDisplayPattern()|default:""}
          {/strip}</a>
          <a id="albumItem{$track.Album.id}Display" href="{modurl modname='MUSound' type='user' func='display' ot='album' id=$track.Album.id theme='Printer' forcelongurl=true}" title="{gt text='Open quick view window'}" class="z-hide">{icon type='view' size='extrasmall' __alt='Quick view'}</a>
          <script type="text/javascript">
          /* <![CDATA[ */
              document.observe('dom:loaded', function() {
                  musoundInitInlineWindow($('albumItem{{$track.Album.id}}Display'), '{{$track.Album->getTitleFromDisplayPattern()|replace:"'":""}}');
              });
          /* ]]> */
          </script>
          {else}
            {$track.Album->getTitleFromDisplayPattern()|default:""}
          {/if}
        {else}
            {gt text='Not set.'}
        {/if}
        </dd>
        
    </dl>
 
    <div id="wrapper2"></div>
    {* <audio src="{$baseurl}{$track.uploadTrackFullPath}" preload="auto" /> *}
		
    {include file='user/include_standardfields_display.tpl' obj=$track}

    {if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
        {* include display hooks *}
        {notifydisplayhooks eventname='musound.ui_hooks.tracks.display_view' id=$track.id urlobject=$currentUrlObject assign='hooks'}
        {foreach key='providerArea' item='hook' from=$hooks}
            {$hook}
        {/foreach}
        {if count($track._actions) gt 0}
            <p id="itemActions">
            {foreach item='option' from=$track._actions}
                <a href="{$option.url.type|musoundActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}" class="z-icon-es-{$option.icon}">{$option.linkText|safetext}</a>
            {/foreach}
            </p>
            <script type="text/javascript">
            /* <![CDATA[ */
                document.observe('dom:loaded', function() {
                    musoundInitItemActions('track', 'display', 'itemActions');
                });
                
            /* ]]> */
            </script>
        {/if}
    {/if}
</div>
{include file='user/footer.tpl'}
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