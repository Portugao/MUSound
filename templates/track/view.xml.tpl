{* purpose of this template: tracks view xml view *}
{musoundTemplateHeaders contentType='text/xml'}<?xml version="1.0" encoding="{charset}" ?>
<tracks>
{foreach item='item' from=$items}
    {include file='track/include.xml.tpl'}
{foreachelse}
    <noTrack />
{/foreach}
</tracks>
