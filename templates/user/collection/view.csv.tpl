{* purpose of this template: collections view csv view in user area *}
{musoundTemplateHeaders contentType='text/comma-separated-values; charset=iso-8859-15' asAttachment=true filename='Collections.csv'}
{strip}"{gt text='Title'}";"{gt text='Description'}";"{gt text='Workflow state'}"
;"{gt text='Album'}"
{/strip}
{foreach item='collection' from=$items}
{strip}
    "{$collection.title}";"{$collection.description}";"{$item.workflowState|musoundObjectState:false|lower}"
    ;"
        {if isset($collection.Album) && $collection.Album ne null}
            {foreach name='relationLoop' item='relatedItem' from=$collection.Album}
            {$relatedItem->getTitleFromDisplayPattern()|default:''}{if !$smarty.foreach.relationLoop.last}, {/if}
            {/foreach}
        {/if}
    "
{/strip}
{/foreach}
