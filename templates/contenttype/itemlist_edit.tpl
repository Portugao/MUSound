{* Purpose of this template: edit view of generic item list content type *}
<div class="z-formrow">
    {gt text='Object type' domain='module_musound' assign='objectTypeSelectorLabel'}
    {formlabel for='mUSoundObjectType' text=$objectTypeSelectorLabel}
        {musoundObjectTypeSelector assign='allObjectTypes'}
        {formdropdownlist id='mUSoundOjectType' dataField='objectType' group='data' mandatory=true items=$allObjectTypes}
        <span class="z-sub z-formnote">{gt text='If you change this please save the element once to reload the parameters below.' domain='module_musound'}</span>
</div>

{formvolatile}
{if $properties ne null && is_array($properties)}
    {nocache}
    {foreach key='registryId' item='registryCid' from=$registries}
        {assign var='propName' value=''}
        {foreach key='propertyName' item='propertyId' from=$properties}
            {if $propertyId eq $registryId}
                {assign var='propName' value=$propertyName}
            {/if}
        {/foreach}
        <div class="z-formrow">
            {modapifunc modname='MUSound' type='category' func='hasMultipleSelection' ot=$objectType registry=$propertyName assign='hasMultiSelection'}
            {gt text='Category' domain='module_musound' assign='categorySelectorLabel'}
            {assign var='selectionMode' value='single'}
            {if $hasMultiSelection eq true}
                {gt text='Categories' domain='module_musound' assign='categorySelectorLabel'}
                {assign var='selectionMode' value='multiple'}
            {/if}
            {formlabel for="mUSoundCatIds`$propertyName`" text=$categorySelectorLabel}
                {formdropdownlist id="mUSoundCatIds`$propName`" items=$categories.$propName dataField="catids`$propName`" group='data' selectionMode=$selectionMode}
                <span class="z-sub z-formnote">{gt text='This is an optional filter.' domain='module_musound'}</span>
        </div>
    {/foreach}
    {/nocache}
{/if}
{/formvolatile}

<div class="z-formrow">
    {gt text='Sorting' domain='module_musound' assign='sortingLabel'}
    {formlabel text=$sortingLabel}
    <div>
        {formradiobutton id='mUSoundSortRandom' value='random' dataField='sorting' group='data' mandatory=true}
        {gt text='Random' domain='module_musound' assign='sortingRandomLabel'}
        {formlabel for='mUSoundSortRandom' text=$sortingRandomLabel}
        {formradiobutton id='mUSoundSortNewest' value='newest' dataField='sorting' group='data' mandatory=true}
        {gt text='Newest' domain='module_musound' assign='sortingNewestLabel'}
        {formlabel for='mUSoundSortNewest' text=$sortingNewestLabel}
        {formradiobutton id='mUSoundSortDefault' value='default' dataField='sorting' group='data' mandatory=true}
        {gt text='Default' domain='module_musound' assign='sortingDefaultLabel'}
        {formlabel for='mUSoundSortDefault' text=$sortingDefaultLabel}
    </div>
</div>

<div class="z-formrow">
    {gt text='Amount' domain='module_musound' assign='amountLabel'}
    {formlabel for='mUSoundAmount' text=$amountLabel}
        {formintinput id='mUSoundAmount' dataField='amount' group='data' mandatory=true maxLength=2}
</div>

<div class="z-formrow">
    {gt text='Template' domain='module_musound' assign='templateLabel'}
    {formlabel for='mUSoundTemplate' text=$templateLabel}
        {musoundTemplateSelector assign='allTemplates'}
        {formdropdownlist id='mUSoundTemplate' dataField='template' group='data' mandatory=true items=$allTemplates}
</div>

<div id="customTemplateArea" class="z-formrow z-hide">
    {gt text='Custom template' domain='module_musound' assign='customTemplateLabel'}
    {formlabel for='mUSoundCustomTemplate' text=$customTemplateLabel}
        {formtextinput id='mUSoundCustomTemplate' dataField='customTemplate' group='data' mandatory=false maxLength=80}
        <span class="z-sub z-formnote">{gt text='Example' domain='module_musound'}: <em>itemlist_[objectType]_display.tpl</em></span>
</div>

<div class="z-formrow z-hide">
    {gt text='Filter (expert option)' domain='module_musound' assign='filterLabel'}
    {formlabel for='mUSoundFilter' text=$filterLabel}
        {formtextinput id='mUSoundFilter' dataField='filter' group='data' mandatory=false maxLength=255}
        <span class="z-sub z-formnote">
            ({gt text='Syntax examples' domain='module_musound'}: <kbd>name:like:foobar</kbd> {gt text='or'} <kbd>status:ne:3</kbd>)
        </span>
</div>

{pageaddvar name='javascript' value='prototype'}
<script type="text/javascript">
/* <![CDATA[ */
    function mUMUSoundToggleCustomTemplate() {
        if ($F('mUSoundTemplate') == 'custom') {
            $('customTemplateArea').removeClassName('z-hide');
        } else {
            $('customTemplateArea').addClassName('z-hide');
        }
    }

    document.observe('dom:loaded', function() {
        mUMUSoundToggleCustomTemplate();
        $('mUSoundTemplate').observe('change', function(e) {
            mUMUSoundToggleCustomTemplate();
        });
    });
/* ]]> */
</script>
