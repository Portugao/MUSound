{assign var='lct' value='user'}
{if isset($smarty.get.lct) && $smarty.get.lct eq 'admin'}
    {assign var='lct' value='admin'}
{/if}

{if $coredata.MUSound.useStandard eq false && $lct eq 'user'}
{pageaddvarblock name='header'}
       <script>
      jQuery(function() { 
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
      });
    </script>
{/pageaddvarblock}
{/if}

{* purpose of this template: inclusion template for display of related tracks in user area *}
{if !isset($nolink)}
    {assign var='nolink' value=false}
{/if}
{if $lct eq 'admin'}
{if isset($items) && $items ne null && count($items) gt 0}
<ul class="musound-related-item-list track">
{foreach name='relLoop' item='item' from=$items}
    <li>
{strip}
{if !$nolink}
    <a href="{modurl modname='MUSound' type='user' func='display' ot='track' id=$item.id}" title="{$item->getTitleFromDisplayPattern()|replace:"\"":""}">
{/if}
    {$item->getTitleFromDisplayPattern()}
{if !$nolink}
    </a>
    <a id="trackItem{$item.id}Display" href="{modurl modname='MUSound' type='user' func='display' ot='track' id=$item.id theme='Printer' forcelongurl=true}" title="{gt text='Open quick view window'}" class="z-hide">{icon type='view' size='extrasmall' __alt='Quick view'}</a>
{/if}
{/strip}
{if !$nolink}
<script type="text/javascript">
/* <![CDATA[ */
    document.observe('dom:loaded', function() {
        mUMUSoundInitInlineWindow($('trackItem{{$item.id}}Display'), '{{$item->getTitleFromDisplayPattern()|replace:"'":""}}');
    });
/* ]]> */
</script>
{/if}
    </li>
{/foreach}
</ul>
{/if}
{/if}

{if $lct eq 'user'}
{checkpermission component='MUSound::' instance='.*' level='ACCESS_EDIT' assign='authEdit'}
	{if $coredata.MUSound.useStandard eq false}	
	<div id="wrapper">
      <audio preload></audio>
      <ol>
      {foreach name=albumtracks item=track from=$items}    
        <li><a href="{modurl modname='MUSound' type='user' func='edit' ot='track' id=$track.id}" data-src="{$track.uploadTrackFullPathUrl}">{$track.title}</a></li>
      {/foreach}
      </ol>
    </div>
    {else}    
	<div id="wrapper2"></div>
	{/if}
{if $coredata.MUSound.useStandard eq true}
<script type="text/javascript">
/* <![CDATA[ */
    var MU = jQuery.noConflict();
    jQuery(document).ready(function(){

    var myPlaylist = [
    {{foreach name=albumtracks item=track from=$items}}
        {
            oga:'',
            mp3:'{{$track.uploadTrackFullPathUrl}}',
            title:'{{$track.title}}',
            artist:'{{if $track.author ne ''}}{{$track.author}}{{else}}{{$track.album.author}}{{/if}}',
            cover:'{{if $track.album.uploadCoverFullPathUrl}}{{$track.album.uploadCoverFullPathUrl}}{{else}}/modules/MUSound/images/NoCover.jpg{{/if}}'
        }{{if $smarty.foreach.albumtracks.last ne true}},{{/if}}
    {{/foreach}}
    ];
            var description = '{{$track.album.description}}';

            MU('#wrapper2').ttwMusicPlayer(myPlaylist, {
                autoPlay:false, 
                description:description,
                jPlayer:{
                    swfPath:'/modules/MUSound/lib/vendor/musicplayer/jquery-jplayer/' //You need to override the default swf path any time the directory structure changes
                }
            }); 
    });
/* ]]> */
</script>
{/if}
{/if}

{if $authEdit eq true}
    <form method="post" action="{modurl modname='MUSound' type='track' func='savePosition'}">
    <ul id="sortable">
	{foreach name=albumtracks item=track from=$items}
		<li class="ui-state-default movecursor">
		    <div class="movetrack">
		    {$track.title} <a title="{gt text='Edit'}" href="{modurl modname='MUSound' type='user' func='edit' ot='track' id=$track.id}"> <i class="fa fa-pencil-square-o fa-lg"> </i></a>
		    <input name="tracks[]" type="hidden" value={$track.id} />
		    </div>
		</li>
	{/foreach}
	</ul>
	<br style="clear: both; "/><input type="submit" value='{gt text="Save positions"}' />
	</form>
	<script type="text/javascript" charset="utf-8">
    /* <![CDATA[ */

    var MU = jQuery.noConflict();

        MU(function() {
            MU( "#sortable" ).sortable();
        });

    /* ]]> */
    </script>
{/if}
