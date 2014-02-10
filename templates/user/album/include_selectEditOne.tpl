{* purpose of this template: inclusion template for managing related album in user area *}
{if !isset($displayMode)}
    {assign var='displayMode' value='dropdown'}
{/if}
{if !isset($allowEditing)}
    {assign var='allowEditing' value=false}
{/if}
{if isset($panel) && $panel eq true}
    <h3 class="album z-panel-header z-panel-indicator z-pointer">{gt text='Album'}</h3>
    <fieldset class="album z-panel-content" style="display: none">
{else}
    <fieldset class="album">
{/if}
    <legend>{gt text='Album'}</legend>
    <div class="z-formrow">
    {if $displayMode eq 'dropdown'}
        {formlabel for=$alias __text='Choose album'}
            {musoundRelationSelectorList group=$group id=$alias aliasReverse=$aliasReverse mandatory=$mandatory __title='Choose the album' selectionMode='single' objectType='album' linkingItem=$linkingItem}
    {elseif $displayMode eq 'autocomplete'}
        {assign var='createLink' value=''}
        {if $allowEditing eq true}
            {modurl modname='MUSound' type='user' func='edit' ot='album' forcelongurl=true assign='createLink'}
        {/if}
        {musoundRelationSelectorAutoComplete group=$group id=$alias aliasReverse=$aliasReverse mandatory=$mandatory __title='Choose the album' selectionMode='single' objectType='album' linkingItem=$linkingItem idPrefix=$idPrefix createLink=$createLink withImage=true}
        <div class="musound-relation-leftside">
            {if isset($linkingItem.$alias)}
                {include file='user/album/include_selectEditItemListOne.tpl'  item=$linkingItem.$alias}
            {else}
                {include file='user/album/include_selectEditItemListOne.tpl' }
            {/if}
        </div>
        <br class="z-clearer" />
    {/if}
    </div>
</fieldset>
