{* purpose of this template: collections xml inclusion template *}
<collection id="{$collection.id}" createdon="{$collection.createdDate|dateformat}" updatedon="{$collection.updatedDate|dateformat}">
    <id>{$collection.id}</id>
    <title><![CDATA[{$collection.title}]]></title>
    <description><![CDATA[{$collection.description}]]></description>
    <workflowState>{$collection.workflowState|musoundObjectState:false|lower}</workflowState>
    <album>
    {if isset($collection.album) && $collection.album ne null}
        {foreach name='relationLoop' item='relatedItem' from=$collection.album}
        <album>{$relatedItem->getTitleFromDisplayPattern()|default:''}</album>
        {/foreach}
    {/if}
    </album>
</collection>
