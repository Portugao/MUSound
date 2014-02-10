{* purpose of this template: tracks atom feed in user area *}
{musoundTemplateHeaders contentType='application/atom+xml'}<?xml version="1.0" encoding="{charset assign='charset'}{if $charset eq 'ISO-8859-15'}ISO-8859-1{else}{$charset}{/if}" ?>
<feed xmlns="http://www.w3.org/2005/Atom">
{gt text='Latest tracks' assign='channelTitle'}
{gt text='A direct feed showing the list of tracks' assign='channelDesc'}
    <title type="text">{$channelTitle}</title>
    <subtitle type="text">{$channelDesc} - {$modvars.ZConfig.slogan}</subtitle>
    <author>
        <name>{$modvars.ZConfig.sitename}</name>
    </author>
{assign var='numItems' value=$items|@count}
{if $numItems}
{capture assign='uniqueID'}tag:{$baseurl|replace:'http://':''|replace:'/':''},{$items[0].createdDate|dateformat|default:$smarty.now|dateformat:'%Y-%m-%d'}:{modurl modname='MUSound' type='user' func='display' ot='track' id=$items[0].id}{/capture}
    <id>{$uniqueID}</id>
    <updated>{$items[0].updatedDate|default:$smarty.now|dateformat:'%Y-%m-%dT%H:%M:%SZ'}</updated>
{/if}
    <link rel="alternate" type="text/html" hreflang="{lang}" href="{modurl modname='MUSound' type='user' func='main' fqurl=1}" />
    <link rel="self" type="application/atom+xml" href="{php}echo substr(\System::getBaseURL(), 0, strlen(\System::getBaseURL())-1);{/php}{getcurrenturi}" />
    <rights>Copyright (c) {php}echo date('Y');{/php}, {$baseurl}</rights>

{foreach item='track' from=$items}
    <entry>
        <title type="html">{$track->getTitleFromDisplayPattern()|notifyfilters:'musound.filterhook.tracks'}</title>
        <link rel="alternate" type="text/html" href="{modurl modname='MUSound' type='user' func='display' ot='track' id=$track.id fqurl='1'}" />

        {capture assign='uniqueID'}tag:{$baseurl|replace:'http://':''|replace:'/':''},{$track.createdDate|dateformat|default:$smarty.now|dateformat:'%Y-%m-%d'}:{modurl modname='MUSound' type='user' func='display' ot='track' id=$track.id}{/capture}
        <id>{$uniqueID}</id>
        {if isset($track.updatedDate) && $track.updatedDate ne null}
            <updated>{$track.updatedDate|dateformat:'%Y-%m-%dT%H:%M:%SZ'}</updated>
        {/if}
        {if isset($track.createdDate) && $track.createdDate ne null}
            <published>{$track.createdDate|dateformat:'%Y-%m-%dT%H:%M:%SZ'}</published>
        {/if}
        {if isset($track.createdUserId)}
            {usergetvar name='uname' uid=$track.createdUserId assign='cr_uname'}
            {usergetvar name='name' uid=$track.createdUserId assign='cr_name'}
            <author>
               <name>{$cr_name|default:$cr_uname}</name>
               <uri>{usergetvar name='_UYOURHOMEPAGE' uid=$track.createdUserId assign='homepage'}{$homepage|default:'-'}</uri>
               <email>{usergetvar name='email' uid=$track.createdUserId}</email>
            </author>
        {/if}

        <summary type="html">
            <![CDATA[
            {$track.description|truncate:150:"&hellip;"|default:'-'}
            ]]>
        </summary>
        <content type="html">
            <![CDATA[
            {$track.author|replace:'<br>':'<br />'}
            ]]>
        </content>
    </entry>
{/foreach}
</feed>
