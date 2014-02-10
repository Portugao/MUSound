{* purpose of this template: albums xml inclusion template in admin area *}
<album id="{$item.id}" createdon="{$item.createdDate|dateformat}" updatedon="{$item.updatedDate|dateformat}">
    <id>{$item.id}</id>
    <title><![CDATA[{$item.title}]]></title>
    <description><![CDATA[{$item.description}]]></description>
    <author><![CDATA[{$item.author}]]></author>
    <uploadCover{if $item.uploadCover ne ''} extension="{$item.uploadCoverMeta.extension}" size="{$item.uploadCoverMeta.size}" isImage="{if $item.uploadCoverMeta.isImage}true{else}false{/if}"{if $item.uploadCoverMeta.isImage} width="{$item.uploadCoverMeta.width}" height="{$item.uploadCoverMeta.height}" format="{$item.uploadCoverMeta.format}"{/if}{/if}>{$item.uploadCover}</uploadCover>
    <publishedDate>{$item.publishedDate|dateformat:'datetimebrief'}</publishedDate>
    <publishedText><![CDATA[{$item.publishedText}]]></publishedText>
    <workflowState>{$item.workflowState|musoundObjectState:false|lower}</workflowState>
    <collection>{if isset($item.Collection) && $item.Collection ne null}{$item.Collection->getTitleFromDisplayPattern()|default:''}{/if}</collection>
    <track>
    {if isset($item.Track) && $item.Track ne null}
        {foreach name='relationLoop' item='relatedItem' from=$item.Track}
        <track>{$relatedItem->getTitleFromDisplayPattern()|default:''}</track>
        {/foreach}
    {/if}
    </track>
</album>
