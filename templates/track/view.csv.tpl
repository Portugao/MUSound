{* purpose of this template: tracks view csv view *}
{musoundTemplateHeaders contentType='text/comma-separated-values; charset=iso-8859-15' asAttachment=true filename='Tracks.csv'}
{strip}"{gt text='Title'}";"{gt text='Description'}";"{gt text='Author'}";"{gt text='Upload track'}";"{gt text='Upload zip'}";"{gt text='Workflow state'}"
;"{gt text='Album'}"
{/strip}
{foreach item='track' from=$items}
{strip}
    "{$track.title}";"{$track.description}";"{$track.author}";"{$track.uploadTrack}";"{$track.uploadZip}";"{$item.workflowState|musoundObjectState:false|lower}"
    ;"{if isset($track.Album) && $track.Album ne null}{$track.Album->getTitleFromDisplayPattern()|default:''}{/if}"
{/strip}
{/foreach}
