{* Purpose of this template: Display tracks within an external context *}
{foreach item='track' from=$items}
    <h3>{$track->getTitleFromDisplayPattern()}</h3>
    <p><a href="{modurl modname='MUSound' type='user' func='display' ot=$objectType id=$track.id}">{gt text='Read more'}</a>
    </p>
{/foreach}
