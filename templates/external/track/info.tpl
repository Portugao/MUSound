{* Purpose of this template: Display item information for previewing from other modules *}
<dl id="track{$track.id}">
<dt>{$track->getTitleFromDisplayPattern()|notifyfilters:'musound.filter_hooks.tracks.filter'|htmlentities}</dt>
{if $track.description ne ''}<dd>{$track.description}</dd>{/if}
</dl>
