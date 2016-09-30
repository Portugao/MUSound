{* purpose of this template: header for user area *}
{pageaddvar name='javascript' value='prototype'}
{pageaddvar name='javascript' value='validation'}
{pageaddvar name='javascript' value='zikula'}
{pageaddvar name='javascript' value='livepipe'}
{pageaddvar name='javascript' value='zikula.ui'}
{pageaddvar name='javascript' value='zikula.imageviewer'}
{pageaddvar name='javascript' value='modules/MUSound/javascript/MUSound.js'}

{* initialise additional gettext domain for translations within javascript *}
{pageaddvar name='jsgettext' value='module_musound_js:MUSound'}
{if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
    <div class="z-frontendbox">
        <h2>{modgetinfo info='displayname'}{if $templateTitle}: {$templateTitle}{/if}</h2>
        {modulelinks modname='MUSound' type='user'}
    </div>
    {nocache}
        {musoundModerationObjects assign='moderationObjects'}
        {if count($moderationObjects) gt 0}
            {foreach item='modItem' from=$moderationObjects}
                <p class="z-informationmsg z-center">
                    <a href="{modurl modname='MUSound' type='admin' func='view' ot=$modItem.objectType workflowState=$modItem.state}" class="z-bold">{$modItem.message}</a>
                </p>
            {/foreach}
        {/if}
    {/nocache}
{/if}
{insert name='getstatusmsg'}
