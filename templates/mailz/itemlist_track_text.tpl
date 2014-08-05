{* Purpose of this template: Display tracks in text mailings *}
{foreach item='track' from=$items}
{$track->getTitleFromDisplayPattern()}
{modurl modname='MUSound' type='user' func='display' ot='track'  id=$$objectType.id fqurl=true}
-----
{foreachelse}
{gt text='No tracks found.'}
{/foreach}
