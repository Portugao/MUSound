{* purpose of this template: collections view xml view in user area *}
{musoundTemplateHeaders contentType='text/xml'}<?xml version="1.0" encoding="{charset}" ?>
<collections>
{foreach item='item' from=$items}
    {include file='user/collection/include.xml'}
{foreachelse}
    <noCollection />
{/foreach}
</collections>
