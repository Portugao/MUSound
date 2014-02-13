{* purpose of this template: tracks display view in user area *}
{include file='user/header.tpl'}
{pageaddvar name='javascript' value='jquery'}
{pageaddvar name='javascript' value='jquery-ui'}
{pageaddvar name='javascript' value='modules/MUSound/lib/vendor/audiojs/audio.min.js'}
{pageaddvar name='javascript' value='modules/MUSound/lib/vendor/jPlayer/jquery.jplayer.min.js'}
{pageaddvar name='javascript' value='modules/MUSound/lib/vendor/jPlayer/add-on/jplayer.playlist.min.js'}
{pageaddvar name='javascript' value='modules/MUSound/lib/vendor/jPlayer/add-on/jquery.jplayer.inspector.js'}
{pageaddvar name='stylesheet' value='modules/MUSound/lib/vendor/jPlayer/skins/pink.flag/jplayer.pink.flag.css'}

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
    <div id="jquery_jplayer_1" class="jp-jplayer"></div>

		<div id="jp_container_1" class="jp-audio">
			<div class="jp-type-single">
				<div class="jp-gui jp-interface">
					<ul class="jp-controls">
						<li><a href="javascript:;" class="jp-play" tabindex="1">play</a></li>
						<li><a href="javascript:;" class="jp-pause" tabindex="1">pause</a></li>
						<li><a href="javascript:;" class="jp-stop" tabindex="1">stop</a></li>
						<li><a href="javascript:;" class="jp-mute" tabindex="1" title="mute">mute</a></li>
						<li><a href="javascript:;" class="jp-unmute" tabindex="1" title="unmute">unmute</a></li>
						<li><a href="javascript:;" class="jp-volume-max" tabindex="1" title="max volume">max volume</a></li>
					</ul>
					<div class="jp-progress">
						<div class="jp-seek-bar">
							<div class="jp-play-bar"></div>

						</div>
					</div>
					<div class="jp-volume-bar">
						<div class="jp-volume-bar-value"></div>
					</div>
					<div class="jp-current-time"></div>
					<div class="jp-duration"></div>
					<ul class="jp-toggles">
						<li><a href="javascript:;" class="jp-repeat" tabindex="1" title="repeat">repeat</a></li>
						<li><a href="javascript:;" class="jp-repeat-off" tabindex="1" title="repeat off">repeat off</a></li>
					</ul>
				</div>
				<div class="jp-title">
					<ul>
						<li>{$track.title}</li>
					</ul>
				</div>
				<div class="jp-no-solution">
					<span>Update Required</span>
					To play the media you will need to either update your browser to a recent version or update your <a href="http://get.adobe.com/flashplayer/" target="_blank">Flash plugin</a>.
				</div>
			</div>
		</div>
		<audio src="{$baseurl}{$track.uploadTrackFullPath}" preload="auto" />
		<div id="track-details">{$track.title} by {$track.author}</div>
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
            <script type="text/javascript">
            /* <![CDATA[ */
                var MU = jQuery.noConflict();  
                MU(document).ready(function(){
	            MU("#jquery_jplayer_1").jPlayer({
		            ready: function () {
			        MU(this).jPlayer("setMedia", {
                    mp3: "{{$baseurl}}{{$track.uploadTrackFullPath}}"
        	    });
		        },
		        swfPath: "/modules/MUSound/lib/vendor/jPlayer",
		        supplied: "mp3, mp4, oga"
	            });
	            });
	            
  audiojs.events.ready(function() {
    var as = audiojs.createAll();
  });


            /* ]]> */
            </script>