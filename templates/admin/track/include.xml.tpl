{* purpose of this template: tracks xml inclusion template in admin area *}
<track id="{$item.id}" createdon="{$item.createdDate|dateformat}" updatedon="{$item.updatedDate|dateformat}">
    <id>{$item.id}</id>
    <title><![CDATA[{$item.title}]]></title>
    <description><![CDATA[{$item.description}]]></description>
    <author><![CDATA[{$item.author}]]></author>
    <uploadTrack{if $item.uploadTrack ne ''} extension="{$item.uploadTrackMeta.extension}" size="{$item.uploadTrackMeta.size}" isImage="{if $item.uploadTrackMeta.isImage}true{else}false{/if}"{if $item.uploadTrackMeta.isImage} width="{$item.uploadTrackMeta.width}" height="{$item.uploadTrackMeta.height}" format="{$item.uploadTrackMeta.format}"{/if}{/if}>{$item.uploadTrack}</uploadTrack>
    <uploadZip{if $item.uploadZip ne ''} extension="{$item.uploadZipMeta.extension}" size="{$item.uploadZipMeta.size}" isImage="{if $item.uploadZipMeta.isImage}true{else}false{/if}"{if $item.uploadZipMeta.isImage} width="{$item.uploadZipMeta.width}" height="{$item.uploadZipMeta.height}" format="{$item.uploadZipMeta.format}"{/if}{/if}>{$item.uploadZip}</uploadZip>
    <workflowState>{$item.workflowState|musoundObjectState:false|lower}</workflowState>
    <album>{if isset($item.Album) && $item.Album ne null}{$item.Album->getTitleFromDisplayPattern()|default:''}{/if}</album>
</track>
