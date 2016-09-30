{* purpose of this template: albums view csv view *}
{musoundTemplateHeaders contentType='text/comma-separated-values; charset=iso-8859-15' asAttachment=true fileName='Albums.csv'}
{strip}"{gt text='Title'}";"{gt text='Description'}";"{gt text='Author'}";"{gt text='Upload cover'}";"{gt text='Published date'}";"{gt text='Published text'}";"{gt text='Workflow state'}"
;"{gt text='Collection'}"
;"{gt text='Track'}"
{/strip}
{foreach item='album' from=$items}
{strip}
    "{$album.title}";"{$album.description}";"{$album.author}";"{$album.uploadCover}";"{$album.publishedDate|dateformat:'datetimebrief'}";"{$album.publishedText}";"{$album.workflowState|musoundObjectState:false|lower}"
    ;"{if isset($album.collection) && $album.collection ne null}{$album.collection->getTitleFromDisplayPattern()|default:''}{/if}"
    ;"
    {if isset($album.track) && $album.track ne null}
        {foreach name='relationLoop' item='relatedItem' from=$album.track}
        {$relatedItem->getTitleFromDisplayPattern()|default:''}{if !$smarty.foreach.relationLoop.last}, {/if}
        {/foreach}
    {/if}
    "
{/strip}
{/foreach}
