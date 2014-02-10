{* purpose of this template: albums view xml view in admin area *}
{musoundTemplateHeaders contentType='text/xml'}<?xml version="1.0" encoding="{charset}" ?>
<albums>
{foreach item='item' from=$items}
    {include file='admin/album/include.xml'}
{foreachelse}
    <noAlbum />
{/foreach}
</albums>
