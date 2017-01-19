{* purpose of this template: inclusion template for managing related albums *}
{if !isset($displayMode)}
    {assign var='displayMode' value='choices'}
{/if}
{if !isset($allowEditing)}
    {assign var='allowEditing' value=false}
{/if}
{if isset($panel) && $panel eq true}
    <h3 class="albums z-panel-header z-panel-indicator z-pointer">{gt text='Albums'}</h3>
    <fieldset class="albums z-panel-content" style="display: none">
{else}
    <fieldset class="albums">
{/if}
    <legend>{gt text='Albums'}</legend>
    <div class="z-formrow">
    {if $displayMode eq 'choices'}
        {formlabel for=$alias __text='Choose albums'}
        {musoundRelationSelectorList group=$group id=$alias aliasReverse=$aliasReverse mandatory=$mandatory __title='Choose the albums' selectionMode='multiple' objectType='album' linkingItem=$linkingItem}
    {elseif $displayMode eq 'autocomplete'}
                
    {/if}
    </div>
{if isset($panel) && $panel eq true}
    </fieldset>
{else}
    </fieldset>
{/if}
