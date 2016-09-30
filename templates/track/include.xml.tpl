{* purpose of this template: tracks xml inclusion template *}
<track id="{$track.id}" createdon="{$track.createdDate|dateformat}" updatedon="{$track.updatedDate|dateformat}">
    <id>{$track.id}</id>
    <title><![CDATA[{$track.title}]]></title>
    <description><![CDATA[{$track.description}]]></description>
    <author><![CDATA[{$track.author}]]></author>
    <uploadTrack{if $track.uploadTrack ne ''} extension="{$track.uploadTrackMeta.extension}" size="{$track.uploadTrackMeta.size}" isImage="{if $track.uploadTrackMeta.isImage}true{else}false{/if}"{if $track.uploadTrackMeta.isImage} width="{$track.uploadTrackMeta.width}" height="{$track.uploadTrackMeta.height}" format="{$track.uploadTrackMeta.format}"{/if}{/if}>{$track.uploadTrack}</uploadTrack>
    <uploadZip{if $track.uploadZip ne ''} extension="{$track.uploadZipMeta.extension}" size="{$track.uploadZipMeta.size}" isImage="{if $track.uploadZipMeta.isImage}true{else}false{/if}"{if $track.uploadZipMeta.isImage} width="{$track.uploadZipMeta.width}" height="{$track.uploadZipMeta.height}" format="{$track.uploadZipMeta.format}"{/if}{/if}>{$track.uploadZip}</uploadZip>
    <pos>{$track.pos}</pos>
    <workflowState>{$track.workflowState|musoundObjectState:false|lower}</workflowState>
    <album>{if isset($track.album) && $track.album ne null}{$track.album->getTitleFromDisplayPattern()|default:''}{/if}</album>
</track>
