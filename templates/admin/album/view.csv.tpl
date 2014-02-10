{* purpose of this template: albums view csv view in admin area *}
{musoundTemplateHeaders contentType='text/comma-separated-values; charset=iso-8859-15' asAttachment=true filename='Albums.csv'}
{strip}"{gt text='Title'}";"{gt text='Description'}";"{gt text='Author'}";"{gt text='Upload cover'}";"{gt text='Published date'}";"{gt text='Published text'}";"{gt text='Workflow state'}"
;"{gt text='Collection'}"
;"{gt text='Track'}"
{/strip}
{foreach item='album' from=$items}
{strip}
    "{$album.title}";"{$album.description}";"{$album.author}";"{$album.uploadCover}";"{$album.publishedDate|dateformat:'datetimebrief'}";"{$album.publishedText}";"{$item.workflowState|musoundObjectState:false|lower}"
    ;"{if isset($album.Collection) && $album.Collection ne null}{$album.Collection->getTitleFromDisplayPattern()|default:''}{/if}"
    ;"
        {if isset($album.Track) && $album.Track ne null}
            {foreach name='relationLoop' item='relatedItem' from=$album.Track}
            {$relatedItem->getTitleFromDisplayPattern()|default:''}{if !$smarty.foreach.relationLoop.last}, {/if}
            {/foreach}
        {/if}
    "
{/strip}
{/foreach}
