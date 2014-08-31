{* Purpose of this template: Display tracks within an external context *}
<dl>
    {foreach item='track' from=$items}
        <dt>{$track->getTitleFromDisplayPattern()}</dt>
        {if $track.description}
            <dd>{$track.description|strip_tags|truncate:200:'&hellip;'}</dd>
        {/if}
        <dd><a href="{modurl modname='MUSound' type='user' ot='track' func='display'  id=$track.id}">{gt text='Read more'}</a>
        </dd>
    {foreachelse}
        <dt>{gt text='No entries found.'}</dt>
    {/foreach}
</dl>
