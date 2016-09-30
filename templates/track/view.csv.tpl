{* purpose of this template: tracks view csv view *}
{musoundTemplateHeaders contentType='text/comma-separated-values; charset=iso-8859-15' asAttachment=true fileName='Tracks.csv'}
{strip}"{gt text='Title'}";"{gt text='Description'}";"{gt text='Author'}";"{gt text='Upload track'}";"{gt text='Upload zip'}";"{gt text='Pos'}";"{gt text='Workflow state'}"
;"{gt text='Album'}"
{/strip}
{foreach item='track' from=$items}
{strip}
    "{$track.title}";"{$track.description}";"{$track.author}";"{$track.uploadTrack}";"{$track.uploadZip}";"{$track.pos}";"{$track.workflowState|musoundObjectState:false|lower}"
    ;"{if isset($track.album) && $track.album ne null}{$track.album->getTitleFromDisplayPattern()|default:''}{/if}"
{/strip}
{/foreach}
