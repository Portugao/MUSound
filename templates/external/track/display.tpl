{* Purpose of this template: Display one certain track within an external context *}
{if $displayMode eq 'embed'}
{pageaddvar name='javascript' value='jquery'}
{pageaddvar name='javascript' value='jquery-ui'}
{/if}
<div id="track{$track.id}" class="musound-external-track">
{if $displayMode eq 'link'}
    <p class="musound-external-link">
    <a href="{modurl modname='MUSound' type='user' func='display' ot='track'  id=$track.id}" title="{$track->getTitleFromDisplayPattern()|replace:"\"":""}">
    {$track->getTitleFromDisplayPattern()|notifyfilters:'musound.filter_hooks.tracks.filter'}
    </a>
    </p>
{/if}
{checkpermissionblock component='MUSound::' instance='::' level='ACCESS_EDIT'}
    {* for normal users without edit permission show only the actual file per default *}
    {if $displayMode eq 'embed'}
        <p class="musound-external-title">
            <strong>{$track->getTitleFromDisplayPattern()|notifyfilters:'musound.filter_hooks.tracks.filter'}</strong>
        </p>
    {/if}
{/checkpermissionblock}

{if $displayMode eq 'link'}
{elseif $displayMode eq 'embed'}
    <div class="musound-external-snippet">
        <audio src="{$baseurl}{$track.uploadTrackFullPath}" preload="auto" />
    </div>

    {* you can distinguish the context like this: *}
    {*if $source eq 'contentType'}
        ...
    {elseif $source eq 'scribite'}
        ...
    {/if*}

    {* you can enable more details about the item: *}
    {*
        <p class="musound-external-description">
            {if $track.description ne ''}{$track.description}<br />{/if}
        </p>
    *}
{/if}
</div>

<script type="text/javascript">
  /* <![CDATA[ */
	            
  audiojs.events.ready(function() {
    var as = audiojs.createAll();
  });


  /* ]]> */
  </script>
