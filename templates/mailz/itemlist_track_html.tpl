{* Purpose of this template: Display tracks in html mailings *}
{*
<ul>
{foreach item='track' from=$items}
    <li>
        <a href="{modurl modname='MUSound' type='user' func='display' ot='track'  id=$$objectType.id fqurl=true}
        ">{$track->getTitleFromDisplayPattern()}
        </a>
    </li>
{foreachelse}
    <li>{gt text='No tracks found.'}</li>
{/foreach}
</ul>
*}

{include file='contenttype/itemlist_track_display_description.tpl'}
