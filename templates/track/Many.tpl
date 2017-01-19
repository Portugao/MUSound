{* purpose of this template: inclusion template for managing related tracks *}
{if !isset($displayMode)}
    {assign var='displayMode' value='choices'}
{/if}
{if !isset($allowEditing)}
    {assign var='allowEditing' value=false}
{/if}
{if isset($panel) && $panel eq true}
    <h3 class="tracks z-panel-header z-panel-indicator z-pointer">{gt text='Tracks'}</h3>
    <fieldset class="tracks z-panel-content" style="display: none">
{else}
    <fieldset class="tracks">
{/if}
    <legend>{gt text='Tracks'}</legend>
    <div class="z-formrow">
    {if $displayMode eq 'choices'}
        {formlabel for=$alias __text='Choose tracks'}
        {musoundRelationSelectorList group=$group id=$alias aliasReverse=$aliasReverse mandatory=$mandatory __title='Choose the tracks' selectionMode='multiple' objectType='track' linkingItem=$linkingItem}
    {elseif $displayMode eq 'autocomplete'}
                
    {/if}
    </div>
{if isset($panel) && $panel eq true}
    </fieldset>
{else}
    </fieldset>
{/if}
