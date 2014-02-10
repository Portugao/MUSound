{* purpose of this template: tracks view xml view in admin area *}
{musoundTemplateHeaders contentType='text/xml'}<?xml version="1.0" encoding="{charset}" ?>
<tracks>
{foreach item='item' from=$items}
    {include file='admin/track/include.xml'}
{foreachelse}
    <noTrack />
{/foreach}
</tracks>
