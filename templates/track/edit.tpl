{* purpose of this template: build the form to edit an instance of track *}
{assign var='lct' value='user'}
{if isset($smarty.get.lct) && $smarty.get.lct eq 'admin'}
    {assign var='lct' value='admin'}
{/if}
{include file="`$lct`/header.tpl"}
{pageaddvar name='javascript' value='modules/MUSound/javascript/MUSound_editFunctions.js'}
{pageaddvar name='javascript' value='modules/MUSound/javascript/MUSound_validation.js'}

{if $mode ne 'create'}
    {gt text='Edit track' assign='templateTitle'}
    {if $lct eq 'admin'}
        {assign var='adminPageIcon' value='edit'}
    {/if}
{elseif $mode eq 'create'}
    {gt text='Create track' assign='templateTitle'}
    {if $lct eq 'admin'}
        {assign var='adminPageIcon' value='new'}
    {/if}
{/if}
<div class="musound-track musound-edit">
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
                                {formtextinput group='track' id='title' mandatory=true readOnly=false __title='Enter the title of the track' textMode='singleline' maxLength=255 cssClass='required'}
                                {musoundValidationError id='title' class='required'}
                            </div>
                            
                            <div class="z-formrow">
                                {formlabel for='description' __text='Description' cssClass=''}
                                {formtextinput group='track' id='description' mandatory=false __title='Enter the description of the track' textMode='multiline' rows='6' cols='50' cssClass=''}
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
                                {formtextinput group="track`$language`" id="title`$language`" mandatory=true readOnly=false __title='Enter the title of the track' textMode='singleline' maxLength=255 cssClass='required'}
                                {musoundValidationError id="title`$language`" class='required'}
                            </div>
                            
                            <div class="z-formrow">
                                {formlabel for="description`$language`" __text='Description' cssClass=''}
                                {formtextinput group="track`$language`" id="description`$language`" mandatory=false __title='Enter the description of the track' textMode='multiline' rows='6' cols='50' cssClass=''}
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
                    {formtextinput group='track' id='title' mandatory=true readOnly=false __title='Enter the title of the track' textMode='singleline' maxLength=255 cssClass='required'}
                    {musoundValidationError id='title' class='required'}
                </div>
                
                <div class="z-formrow">
                    {formlabel for='description' __text='Description' cssClass=''}
                    {formtextinput group='track' id='description' mandatory=false __title='Enter the description of the track' textMode='multiline' rows='6' cols='50' cssClass=''}
                </div>
            </fieldset>
        {/if}
    {/formvolatile}
    <fieldset>
        <legend>{gt text='Further properties'}</legend>
        
        <div class="z-formrow">
            {formlabel for='author' __text='Author' cssClass=''}
            {formtextinput group='track' id='author' mandatory=false readOnly=false __title='Enter the author of the track' textMode='singleline' maxLength=255 cssClass=''}
        </div>
        
        <div class="z-formrow">
            {formlabel for='uploadTrack' __text='Upload track' cssClass=''}<br />{* break required for Google Chrome *}
            {formuploadinput group='track' id='uploadTrack' mandatory=false readOnly=false cssClass=' validate-upload'}
            <span class="z-formnote z-sub"><a id="resetUploadTrackVal" href="javascript:void(0);" class="z-hide" style="clear:left;">{gt text='Reset to empty value'}</a></span>
            
                <span class="z-formnote">{gt text='Allowed file extensions'}: <span id="uploadTrackFileExtensions">mp3</span></span>
            <span class="z-formnote">{gt text='Allowed file size'}: {'1024000'|musoundGetFileSize:'':false:false}</span>
            {if $mode ne 'create' && $track.uploadTrack ne ''}
                <span class="z-formnote">
                    {gt text='Current file'}:
                    <a href="{$track.uploadTrackFullPathUrl}" title="{$formattedEntityTitle|replace:"\"":""}"{if $track.uploadTrackMeta.isImage} rel="imageviewer[track]"{/if}>
                    {if $track.uploadTrackMeta.isImage}
                        {thumb image=$track.uploadTrackFullPath objectid="track-`$track.id`" preset=$trackThumbPresetUploadTrack tag=true img_alt=$formattedEntityTitle}
                    {else}
                        {gt text='Download'} ({$track.uploadTrackMeta.size|musoundGetFileSize:$track.uploadTrackFullPath:false:false})
                    {/if}
                    </a>
                </span>
                <span class="z-formnote">
                    {formcheckbox group='track' id='uploadTrackDeleteFile' readOnly=false __title='Delete upload track ?'}
                    {formlabel for='uploadTrackDeleteFile' __text='Delete existing file'}
                </span>
            {/if}
            {musoundValidationError id='uploadTrack' class='validate-upload'}
        </div>
        
        <div class="z-formrow">
            {formlabel for='uploadZip' __text='Upload zip' cssClass=''}<br />{* break required for Google Chrome *}
            {formuploadinput group='track' id='uploadZip' mandatory=false readOnly=false cssClass=' validate-upload'}
            <span class="z-formnote z-sub"><a id="resetUploadZipVal" href="javascript:void(0);" class="z-hide" style="clear:left;">{gt text='Reset to empty value'}</a></span>
            
                <span class="z-formnote">{gt text='Allowed file extensions'}: <span id="uploadZipFileExtensions">zip</span></span>
            <span class="z-formnote">{gt text='Allowed file size'}: {'1024000'|musoundGetFileSize:'':false:false}</span>
            {if $mode ne 'create' && $track.uploadZip ne ''}
                <span class="z-formnote">
                    {gt text='Current file'}:
                    <a href="{$track.uploadZipFullPathUrl}" title="{$formattedEntityTitle|replace:"\"":""}"{if $track.uploadZipMeta.isImage} rel="imageviewer[track]"{/if}>
                    {if $track.uploadZipMeta.isImage}
                        {thumb image=$track.uploadZipFullPath objectid="track-`$track.id`" preset=$trackThumbPresetUploadZip tag=true img_alt=$formattedEntityTitle}
                    {else}
                        {gt text='Download'} ({$track.uploadZipMeta.size|musoundGetFileSize:$track.uploadZipFullPath:false:false})
                    {/if}
                    </a>
                </span>
                <span class="z-formnote">
                    {formcheckbox group='track' id='uploadZipDeleteFile' readOnly=false __title='Delete upload zip ?'}
                    {formlabel for='uploadZipDeleteFile' __text='Delete existing file'}
                </span>
            {/if}
            {musoundValidationError id='uploadZip' class='validate-upload'}
        </div>
        
        <div class="z-formrow">
            {formlabel for='pos' __text='Pos' mandatorysym='1' cssClass=''}
            {formintinput group='track' id='pos' mandatory=true __title='Enter the pos of the track' maxLength=11 cssClass='required validate-digits'}
            {musoundValidationError id='pos' class='required'}
            {musoundValidationError id='pos' class='validate-digits'}
        </div>
    </fieldset>
    
    {include file='album/includeSelectEditOne.tpl' group='track' alias='album' aliasReverse='track' mandatory=false idPrefix='musoundTrack_Album' linkingItem=$track displayMode='choices' allowEditing=true}
    {if $mode ne 'create'}
        {include file='helper/includeStandardFieldsEdit.tpl' obj=$track}
    {/if}
    
    {* include display hooks *}
    {if $mode ne 'create'}
        {assign var='hookId' value=$track.id}
        {notifydisplayhooks eventname='musound.ui_hooks.tracks.form_edit' id=$hookId assign='hooks'}
    {else}
        {notifydisplayhooks eventname='musound.ui_hooks.tracks.form_edit' id=null assign='hooks'}
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
    
    
    {* include return control *}
    {if $mode eq 'create'}
        <fieldset>
            <legend>{gt text='Return control'}</legend>
            <div class="z-formrow">
                {formlabel for='repeatCreation' __text='Create another item after save'}
                {formcheckbox group='track' id='repeatCreation' readOnly=false}
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
                {gt text='Really delete this track?' assign='deleteConfirmMsg'}
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
    
        mUMUSoundAddCommonValidationRules('track', '{{if $mode ne 'create'}}{{$track.id}}{{/if}}');
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
        mUMUSoundInitUploadField('uploadTrack');
        mUMUSoundInitUploadField('uploadZip');
    });
/* ]]> */
</script>
