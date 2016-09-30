{* purpose of this template: collections view csv view *}
{musoundTemplateHeaders contentType='text/comma-separated-values; charset=iso-8859-15' asAttachment=true fileName='Collections.csv'}
{strip}"{gt text='Title'}";"{gt text='Description'}";"{gt text='Workflow state'}"
;"{gt text='Album'}"
{/strip}
{foreach item='collection' from=$items}
{strip}
    "{$collection.title}";"{$collection.description}";"{$collection.workflowState|musoundObjectState:false|lower}"
    ;"
    {if isset($collection.album) && $collection.album ne null}
        {foreach name='relationLoop' item='relatedItem' from=$collection.album}
        {$relatedItem->getTitleFromDisplayPattern()|default:''}{if !$smarty.foreach.relationLoop.last}, {/if}
        {/foreach}
    {/if}
    "
{/strip}
{/foreach}
