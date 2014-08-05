{* purpose of this template: inclusion template for display of related tracks in user area *}
{if !isset($nolink)}
    {assign var='nolink' value=false}
{/if}
{*
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
        musoundInitInlineWindow($('trackItem{{$item.id}}Display'), '{{$item->getTitleFromDisplayPattern()|replace:"'":""}}');
    });
/* ]]> */
</script>
{/if}
    </li>
{/foreach}
</ul>
{/if}
*}
		
		<div id="wrapper2"></div>
  
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
