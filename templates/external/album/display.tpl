{* Purpose of this template: Display one certain album within an external context *}
{if $displayMode eq 'embed'}
{pageaddvar name='javascript' value='jquery'}
{pageaddvar name='javascript' value='jquery-ui'}
{pageaddvar name='javascript' value='modules/MUSound/lib/vendor/audiojs/audio.min.js'}
{pageaddvar name='javascript' value='modules/MUSound/lib/vendor/musicplayer/jquery-jplayer/jquery.jplayer.js'}
{pageaddvar name='javascript' value='modules/MUSound/lib/vendor/musicplayer/ttw-music-player-min.js'}
{pageaddvar name='stylesheet' value='modules/MUSound/lib/vendor/musicplayer/css/style.css'}
{/if}
<div id="album{$album.id}" class="musound-external-album">
{if $displayMode eq 'link'}
    <p class="musound-external-link">
    <a href="{modurl modname='MUSound' type='user' func='display' ot='album' id=$album.id}" title="{$album->getTitleFromDisplayPattern()|replace:"\"":""}">
    {$album->getTitleFromDisplayPattern()|notifyfilters:'musound.filter_hooks.albums.filter'}
    </a>
    </p>
{/if}
{checkpermissionblock component='MUSound::' instance='::' level='ACCESS_EDIT'}
    {if $displayMode eq 'embed'}
        <p class="musound-external-title">
            <strong>{$album->getTitleFromDisplayPattern()|notifyfilters:'musound.filter_hooks.albums.filter'}</strong>
        </p>
    {/if}
{/checkpermissionblock}

{if $displayMode eq 'link'}
{elseif $displayMode eq 'embed'}
   {* <div class="musound-external-snippet"> *}
       {* {if $album.uploadCover ne ''}
          <a href="{$album.uploadCoverFullPathURL}" title="{$album->getTitleFromDisplayPattern()|replace:"\"":""}"{if $album.uploadCoverMeta.isImage} rel="imageviewer[album]"{/if}>
          {if $album.uploadCoverMeta.isImage}
              {thumb image=$album.uploadCoverFullPath objectid="album-`$album.id`" preset=$albumThumbPresetUploadCover tag=true img_alt=$album->getTitleFromDisplayPattern()}
          {else}
              {gt text='Download'} ({$album.uploadCoverMeta.size|musoundGetFileSize:$album.uploadCoverFullPath:false:false})
          {/if}
          </a>
        {else}&nbsp;{/if}
        <div id="wrapper">
		<audio preload></audio>
		<ol>
		    {foreach item=track from=$album.track}
		    <li><a href="#" data-src="/{$track.uploadTrackFullPath}">{$track.title} - {$track.author}</a></li>
		    {/foreach}
		</ol>
		
		</div> *}
		<div id="wrapper2"></div>
   {* </div> *}

    {* you can distinguish the context like this: *}
    {*if $source eq 'contentType'}
        ...
    {elseif $source eq 'scribite'}
        ...
    {/if*}

    {* you can enable more details about the item: *}
    {*
        <p class="musound-external-description">
            {if $album.description ne ''}{$album.description}<br />{/if}
            {assignedcategorieslist categories=$album.categories doctrine2=true}
        </p>
    *}
{/if}
</div>
{if $displayMode eq 'embed'}
<script type="text/javascript">  
  //<![CDATA[

    jQuery(document).ready(function(){
 
     {{*  jQuery(function() { 
        // Setup the player to autoplay the next track
        var a = audiojs.createAll({
          trackEnded: function() {
            var next = jQuery('ol li.playing').next();
            if (!next.length) next = jQuery('ol li').first();
            next.addClass('playing').siblings().removeClass('playing');
            audio.load(jQuery('a', next).attr('data-src'));
            audio.play();
          }
        });
        
        // Load in the first track
        var audio = a[0];
            first = jQuery('ol a').attr('data-src');
        jQuery('ol li').first().addClass('playing');
        audio.load(first);

        // Load in a track on click
        jQuery('ol li').click(function(e) {
          e.preventDefault();
          jQuery(this).addClass('playing').siblings().removeClass('playing');
          audio.load(jQuery('a', this).attr('data-src'));
          audio.play();
        });
        // Keyboard shortcuts
        jQuery(document).keydown(function(e) {
          var unicode = e.charCode ? e.charCode : e.keyCode;
             // right arrow
          if (unicode == 39) {
            var next = jQuery('li.playing').next();
            if (!next.length) next = jQuery('ol li').first();
            next.click();
            // back arrow
          } else if (unicode == 37) {
            var prev = jQuery('li.playing').prev();
            if (!prev.length) prev = jQuery('ol li').last();
            prev.click();
            // spacebar
          } else if (unicode == 32) {
            audio.playPause();
          }
        })
      }); *}}
      
          var myPlaylist = [
    {{foreach name=albumtracks item=track from=$album.track}}
        {
            mp3:'{{$track.uploadTrackFullPathUrl}}',
            title:'{{$track.title}}',
            artist:'{{if $track.author ne ''}}{{$track.author}}{{else}}{{$track.album.author}}{{/if}}',
            cover:'{{$track.album.uploadCoverFullPathUrl}}'
        }{{if $smarty.foreach.albumtracks.last ne true}},{{/if}}
    {{/foreach}}
    ];
            var description = '{{$track.album.description}}';

            jQuery('#wrapper2').ttwMusicPlayer(myPlaylist, {
                autoPlay:false, 
                description:description,
                jPlayer:{
                    swfPath:'{{$baseurl}}modules/MUSound/lib/vendor/musicplayer/jquery-jplayer' //You need to override the default swf path any time the directory structure changes
                }
            });
    
    });
/* ]]> */
</script>
{/if}