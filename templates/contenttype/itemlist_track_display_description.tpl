{* Purpose of this template: Display tracks within an external context *}
<dl>
    {foreach item='track' from=$items}
        <dt>{$track->getTitleFromDisplayPattern()}</dt>
        {if $track.description}
            <dd>{$track.description|truncate:200:"..."}</dd>
        {/if}
        <dd><a href="{modurl modname='MUSound' type='user' func='display' ot=$objectType id=$track.id}">{gt text='Read more'}</a>
        </dd>
    {foreachelse}
        <dt>{gt text='No entries found.'}</dt>
    {/foreach}
</dl>
