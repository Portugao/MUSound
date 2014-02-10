{* Purpose of this template: Display albums in text mailings *}
{foreach item='album' from=$items}
{$album->getTitleFromDisplayPattern()}
{modurl modname='MUSound' type='user' func='display' ot=$objectType id=$album.id fqurl=true}
-----
{foreachelse}
{gt text='No albums found.'}
{/foreach}
