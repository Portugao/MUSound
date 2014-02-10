{* purpose of this template: collections xml inclusion template in admin area *}
<collection id="{$item.id}" createdon="{$item.createdDate|dateformat}" updatedon="{$item.updatedDate|dateformat}">
    <id>{$item.id}</id>
    <title><![CDATA[{$item.title}]]></title>
    <description><![CDATA[{$item.description}]]></description>
    <workflowState>{$item.workflowState|musoundObjectState:false|lower}</workflowState>
    <album>
    {if isset($item.Album) && $item.Album ne null}
        {foreach name='relationLoop' item='relatedItem' from=$item.Album}
        <album>{$relatedItem->getTitleFromDisplayPattern()|default:''}</album>
        {/foreach}
    {/if}
    </album>
</collection>
