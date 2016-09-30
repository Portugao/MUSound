{* purpose of this template: albums xml inclusion template *}
<album id="{$album.id}" createdon="{$album.createdDate|dateformat}" updatedon="{$album.updatedDate|dateformat}">
    <id>{$album.id}</id>
    <title><![CDATA[{$album.title}]]></title>
    <description><![CDATA[{$album.description}]]></description>
    <author><![CDATA[{$album.author}]]></author>
    <uploadCover{if $album.uploadCover ne ''} extension="{$album.uploadCoverMeta.extension}" size="{$album.uploadCoverMeta.size}" isImage="{if $album.uploadCoverMeta.isImage}true{else}false{/if}"{if $album.uploadCoverMeta.isImage} width="{$album.uploadCoverMeta.width}" height="{$album.uploadCoverMeta.height}" format="{$album.uploadCoverMeta.format}"{/if}{/if}>{$album.uploadCover}</uploadCover>
    <publishedDate>{$album.publishedDate|dateformat:'datetimebrief'}</publishedDate>
    <publishedText><![CDATA[{$album.publishedText}]]></publishedText>
    <workflowState>{$album.workflowState|musoundObjectState:false|lower}</workflowState>
    <collection>{if isset($album.collection) && $album.collection ne null}{$album.collection->getTitleFromDisplayPattern()|default:''}{/if}</collection>
    <track>
    {if isset($album.track) && $album.track ne null}
        {foreach name='relationLoop' item='relatedItem' from=$album.track}
        <track>{$relatedItem->getTitleFromDisplayPattern()|default:''}</track>
        {/foreach}
    {/if}
    </track>
</album>
