{* Purpose of this template: Display albums within an external context *}
{foreach item='album' from=$items}
    <h3>{$album->getTitleFromDisplayPattern()}</h3>
    <p><a href="{modurl modname='MUSound' type='user' ot='album' func='display'  id=$album.id}">{gt text='Read more'}</a>
    </p>
{/foreach}
