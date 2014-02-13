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

		<div id="wrapper">
		<audio preload></audio>
		<ol>
		    {foreach item=track from=$items}
		    <li><a href="#" data-src="/{$track.uploadTrackFullPath}">{$track.title} - {$track.author}</a></li>
		    {/foreach}
		</ol>
		
		</div>
  
<script type="text/javascript">  
  //<![CDATA[

    jQuery(document).ready(function(){
 
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
    
    });
/* ]]> */
</script>
