{* purpose of this template: build the form to edit an instance of album *}
{assign var='lct' value='user'}
{if isset($smarty.get.lct) && $smarty.get.lct eq 'admin'}
    {assign var='lct' value='admin'}
{/if}
{include file="`$lct`/header.tpl"}
{pageaddvar name='javascript' value='modules/MUSound/javascript/MUSound_editFunctions.js'}
{pageaddvar name='javascript' value='modules/MUSound/javascript/MUSound_validation.js'}

{if $mode ne 'create'}
    {gt text='Edit album' assign='templateTitle'}
    {if $lct eq 'admin'}
        {assign var='adminPageIcon' value='edit'}
    {/if}
{elseif $mode eq 'create'}
    {gt text='Create album' assign='templateTitle'}
    {if $lct eq 'admin'}
        {assign var='adminPageIcon' value='new'}
    {/if}
{/if}
<div class="musound-album musound-edit">
    {pagesetvar name='title' value=$templateTitle}
    {if $lct eq 'admin'}
        <div class="z-admin-content-pagetitle">
            {icon type=$adminPageIcon size='small' alt=$templateTitle}
            <h3>{$templateTitle}</h3>
        </div>
    {else}
        <h2>{$templateTitle}</h2>
    {/if}
{form enctype='multipart/form-data' cssClass='z-form'}
    {* add validation summary and a <div> element for styling the form *}
    {musoundFormFrame}
        {formsetinitialfocus inputId='title'}

    {formvolatile}
        {assign var='useOnlyCurrentLanguage' value=true}
        {if $modvars.ZConfig.multilingual}
            {if is_array($supportedLanguages) && count($supportedLanguages) gt 1}
                {assign var='useOnlyCurrentLanguage' value=false}
                {nocache}
                {lang assign='currentLanguage'}
                {foreach item='language' from=$supportedLanguages}
                    {if $language eq $currentLanguage}
                        <fieldset>
                            <legend>{$language|getlanguagename|safehtml}</legend>
                            
                            <div class="z-formrow">
                                {formlabel for='title' __text='Title' mandatorysym='1' cssClass=''}
                                {formtextinput group='album' id='title' mandatory=true readOnly=false __title='Enter the title of the album' textMode='singleline' maxLength=255 cssClass='required'}
                                {musoundValidationError id='title' class='required'}
                            </div>
                            
                            <div class="z-formrow">
                                {formlabel for='description' __text='Description' cssClass=''}
                                {formtextinput group='album' id='description' mandatory=false __title='Enter the description of the album' textMode='multiline' rows='6' cols='50' cssClass=''}
                            </div>
                        </fieldset>
                    {/if}
                {/foreach}
                {foreach item='language' from=$supportedLanguages}
                    {if $language ne $currentLanguage}
                        <fieldset>
                            <legend>{$language|getlanguagename|safehtml}</legend>
                            
                            <div class="z-formrow">
                                {formlabel for="title`$language`" __text='Title' mandatorysym='1' cssClass=''}
                                {formtextinput group="album`$language`" id="title`$language`" mandatory=true readOnly=false __title='Enter the title of the album' textMode='singleline' maxLength=255 cssClass='required'}
                                {musoundValidationError id="title`$language`" class='required'}
                            </div>
                            
                            <div class="z-formrow">
                                {formlabel for="description`$language`" __text='Description' cssClass=''}
                                {formtextinput group="album`$language`" id="description`$language`" mandatory=false __title='Enter the description of the album' textMode='multiline' rows='6' cols='50' cssClass=''}
                            </div>
                        </fieldset>
                    {/if}
                {/foreach}
                {/nocache}
            {/if}
        {/if}
        {if $useOnlyCurrentLanguage eq true}
            {lang assign='language'}
            <fieldset>
                <legend>{$language|getlanguagename|safehtml}</legend>
                
                <div class="z-formrow">
                    {formlabel for='title' __text='Title' mandatorysym='1' cssClass=''}
                    {formtextinput group='album' id='title' mandatory=true readOnly=false __title='Enter the title of the album' textMode='singleline' maxLength=255 cssClass='required'}
                    {musoundValidationError id='title' class='required'}
                </div>
                
                <div class="z-formrow">
                    {formlabel for='description' __text='Description' cssClass=''}
                    {formtextinput group='album' id='description' mandatory=false __title='Enter the description of the album' textMode='multiline' rows='6' cols='50' cssClass=''}
                </div>
            </fieldset>
        {/if}
    {/formvolatile}
    <fieldset>
        <legend>{gt text='Further properties'}</legend>
        
        <div class="z-formrow">
            {formlabel for='author' __text='Author' cssClass=''}
            {formtextinput group='album' id='author' mandatory=false readOnly=false __title='Enter the author of the album' textMode='singleline' maxLength=255 cssClass=''}
        </div>
        
        <div class="z-formrow">
            {formlabel for='uploadCover' __text='Upload cover' cssClass=''}<br />{* break required for Google Chrome *}
            {formuploadinput group='album' id='uploadCover' mandatory=false readOnly=false cssClass=' validate-upload'}
            <span class="z-formnote z-sub"><a id="resetUploadCoverVal" href="javascript:void(0);" class="z-hide" style="clear:left;">{gt text='Reset to empty value'}</a></span>
            
                <span class="z-formnote">{gt text='Allowed file extensions'}: <span id="uploadCoverFileExtensions">gif, jpeg, jpg, png</span></span>
            <span class="z-formnote">{gt text='Allowed file size'}: {'102400'|musoundGetFileSize:'':false:false}</span>
            {if $mode ne 'create' && $album.uploadCover ne ''}
                <span class="z-formnote">
                    {gt text='Current file'}:
                    <a href="{$album.uploadCoverFullPathUrl}" title="{$formattedEntityTitle|replace:"\"":""}"{if $album.uploadCoverMeta.isImage} rel="imageviewer[album]"{/if}>
                    {if $album.uploadCoverMeta.isImage}
                        {thumb image=$album.uploadCoverFullPath objectid="album-`$album.id`" preset=$albumThumbPresetUploadCover tag=true img_alt=$formattedEntityTitle}
                    {else}
                        {gt text='Download'} ({$album.uploadCoverMeta.size|musoundGetFileSize:$album.uploadCoverFullPath:false:false})
                    {/if}
                    </a>
                </span>
                <span class="z-formnote">
                    {formcheckbox group='album' id='uploadCoverDeleteFile' readOnly=false __title='Delete upload cover ?'}
                    {formlabel for='uploadCoverDeleteFile' __text='Delete existing file'}
                </span>
            {/if}
            {musoundValidationError id='uploadCover' class='validate-upload'}
        </div>
        
        <div class="z-formrow">
            {formlabel for='publishedDate' __text='Published date' cssClass=''}
            {if $mode ne 'create'}
                {formdateinput group='album' id='publishedDate' mandatory=false __title='Enter the published date of the album' includeTime=true cssClass=''}
            {else}
                {formdateinput group='album' id='publishedDate' mandatory=false __title='Enter the published date of the album' includeTime=true cssClass=''}
            {/if}
            <span class="z-formnote z-sub"><a id="resetPublishedDateVal" href="javascript:void(0);" class="z-hide">{gt text='Reset to empty value'}</a></span>
        </div>
        
        <div class="z-formrow">
            {formlabel for='publishedText' __text='Published text' cssClass=''}
            {formtextinput group='album' id='publishedText' mandatory=false readOnly=false __title='Enter the published text of the album' textMode='singleline' maxLength=255 cssClass=''}
        </div>
    </fieldset>
    
    {include file='helper/includeCategoriesEdit.tpl' obj=$album groupName='albumObj'}
    {include file='collection/includeSelectEditOne.tpl' group='album' alias='collection' aliasReverse='album' mandatory=false idPrefix='musoundAlbum_Collection' linkingItem=$album displayMode='choices' allowEditing=true}
    {*include file='track/Many.tpl' group='album' alias='track' aliasReverse='album' mandatory=false idPrefix='musoundAlbum_Track' linkingItem=$album displayMode='choices' allowEditing=true*}
    {if $mode ne 'create'}
        {include file='helper/includeStandardFieldsEdit.tpl' obj=$album}
    {/if}
    
    {* include display hooks *}
    {if $mode ne 'create'}
        {assign var='hookId' value=$album.id}
        {notifydisplayhooks eventname='musound.ui_hooks.albums.form_edit' id=$hookId assign='hooks'}
    {else}
        {notifydisplayhooks eventname='musound.ui_hooks.albums.form_edit' id=null assign='hooks'}
    {/if}
    {if is_array($hooks) && count($hooks)}
        {foreach name='hookLoop' key='providerArea' item='hook' from=$hooks}
            {if $providerArea ne 'provider.scribite.ui_hooks.editor'}{* fix for #664 *}
                <fieldset>
                    {$hook}
                </fieldset>
            {/if}
        {/foreach}
    {/if}
    
    <fieldset>
        <legend>{gt text='Communication'}</legend>
        <div class="z-formrow">
            {formlabel for='additionalNotificationRemarks' __text='Additional remarks'}
            {gt text='Enter any additions about your changes' assign='fieldTitle'}
            {if $mode eq 'create'}
                {gt text='Enter any additions about your content' assign='fieldTitle'}
            {/if}
            {formtextinput group='album' id='additionalNotificationRemarks' mandatory=false title=$fieldTitle textMode='multiline' rows='6' cols='50'}
            {if $isModerator}
                <span class="z-formnote">{gt text='These remarks (like a reason for deny) are not stored, but added to any notification emails send to the creator.'}</span>
            {elseif $isCreator}
                <span class="z-formnote">{gt text='These remarks (like questions about conformance) are not stored, but added to any notification emails send to our moderators.'}</span>
            {/if}
        </div>
    </fieldset>
    
    {* include return control *}
    {if $mode eq 'create'}
        <fieldset>
            <legend>{gt text='Return control'}</legend>
            <div class="z-formrow">
                {formlabel for='repeatCreation' __text='Create another item after save'}
                {formcheckbox group='album' id='repeatCreation' readOnly=false}
            </div>
        </fieldset>
    {/if}
    
    {* include possible submit actions *}
    <div class="z-buttons z-formbuttons">
        {foreach item='action' from=$actions}
            {assign var='actionIdCapital' value=$action.id|@ucfirst}
            {gt text=$action.title assign='actionTitle'}
            {*gt text=$action.description assign='actionDescription'*}{* TODO: formbutton could support title attributes *}
            {if $action.id eq 'delete'}
                {gt text='Really delete this album?' assign='deleteConfirmMsg'}
                {formbutton id="btn`$actionIdCapital`" commandName=$action.id text=$actionTitle class=$action.buttonClass confirmMessage=$deleteConfirmMsg}
            {else}
                {formbutton id="btn`$actionIdCapital`" commandName=$action.id text=$actionTitle class=$action.buttonClass}
            {/if}
        {/foreach}
        {formbutton id='btnCancel' commandName='cancel' __text='Cancel' class='z-bt-cancel' formnovalidate='formnovalidate'}
    </div>
    {/musoundFormFrame}
{/form}
</div>
{include file="`$lct`/footer.tpl"}

{icon type='edit' size='extrasmall' assign='editImageArray'}
{icon type='delete' size='extrasmall' assign='removeImageArray'}


<script type="text/javascript">
/* <![CDATA[ */
    
    var formButtons, formValidator;
    
    function handleFormButton (event) {
        var result = formValidator.validate();
        if (!result) {
            // validation error, abort form submit
            Event.stop(event);
        } else {
            // hide form buttons to prevent double submits by accident
            formButtons.each(function (btn) {
                btn.addClassName('z-hide');
            });
        }
    
        return result;
    }
    
    document.observe('dom:loaded', function() {
    
        mUMUSoundAddCommonValidationRules('album', '{{if $mode ne 'create'}}{{$album.id}}{{/if}}');
        {{* observe validation on button events instead of form submit to exclude the cancel command *}}
        formValidator = new Validation('{{$__formid}}', {onSubmit: false, immediate: true, focusOnError: false});
        {{if $mode ne 'create'}}
            var result = formValidator.validate();
        {{/if}}
    
        formButtons = $('{{$__formid}}').select('div.z-formbuttons input');
    
        formButtons.each(function (elem) {
            if (elem.id != 'btnCancel') {
                elem.observe('click', handleFormButton);
            }
        });
    
        Zikula.UI.Tooltips($$('.musound-form-tooltips'));
        mUMUSoundInitUploadField('uploadCover');
        mUMUSoundInitDateField('publishedDate');
    });
/* ]]> */
</script>
