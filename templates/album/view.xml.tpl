{* purpose of this template: albums view xml view *}
{musoundTemplateHeaders contentType='text/xml'}<?xml version="1.0" encoding="{charset}" ?>
<albums>
{foreach item='album' from=$items}
    {include file='album/include.xml.tpl'}
{foreachelse}
    <noAlbum />
{/foreach}
</albums>
