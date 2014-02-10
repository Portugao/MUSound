{* purpose of this template: build the Form to edit an instance of track *}
{include file='admin/header.tpl'}
{pageaddvar name='javascript' value='modules/MUSound/javascript/MUSound_editFunctions.js'}
{pageaddvar name='javascript' value='modules/MUSound/javascript/MUSound_validation.js'}

{if $mode eq 'edit'}
    {gt text='Edit track' assign='templateTitle'}
    {assign var='adminPageIcon' value='edit'}
{elseif $mode eq 'create'}
    {gt text='Create track' assign='templateTitle'}
    {assign var='adminPageIcon' value='new'}
{else}
    {gt text='Edit track' assign='templateTitle'}
    {assign var='adminPageIcon' value='edit'}
{/if}
<div class="musound-track musound-edit">
    {pagesetvar name='title' value=$templateTitle}
    <div class="z-admin-content-pagetitle">
        {icon type=$adminPageIcon size='small' alt=$templateTitle}
        <h3>{$templateTitle}</h3>
    </div>
{form enctype='multipart/form-data' cssClass='z-form'}
    {* add validation summary and a <div> element for styling the form *}
    {musoundFormFrame}
    {formsetinitialfocus inputId='title'}

    <fieldset>
        <legend>{gt text='Content'}</legend>
        
        <div class="z-formrow">
            {formlabel for='title' __text='Title' mandatorysym='1' cssClass=''}
            {formtextinput group='track' id='title' mandatory=true readOnly=false __title='Enter the title of the track' textMode='singleline' maxLength=255 cssClass='required' }
            {musoundValidationError id='title' class='required'}
        </div>
        
        <div class="z-formrow">
            {formlabel for='description' __text='Description' cssClass=''}
            {formtextinput group='track' id='description' mandatory=false __title='Enter the description of the track' textMode='multiline' rows='6' cols='50' cssClass='' }
        </div>
        
        <div class="z-formrow">
            {formlabel for='author' __text='Author' cssClass=''}
            {formtextinput group='track' id='author' mandatory=false readOnly=false __title='Enter the author of the track' textMode='singleline' maxLength=255 cssClass='' }
        </div>
        
        <div class="z-formrow">
            {formlabel for='uploadTrack' __text='Upload track' cssClass=''}<br />{* break required for Google Chrome *}
            {formuploadinput group='track' id='uploadTrack' mandatory=false readOnly=false cssClass=' validate-upload' }
            <span class="z-formnote"><a id="resetUploadTrackVal" href="javascript:void(0);" class="z-hide" style="clear:left;">{gt text='Reset to empty value'}</a></span>
            
                <span class="z-formnote">{gt text='Allowed file extensions:'} <span id="uploadTrackFileExtensions">mp3</span></span>
            <span class="z-formnote">{gt text='Allowed file size:'} {'1024000'|musoundGetFileSize:'':false:false}</span>
            {if $mode ne 'create'}
                {if $track.uploadTrack ne ''}
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
            {/if}
            {musoundValidationError id='uploadTrack' class='validate-upload'}
        </div>
        
        <div class="z-formrow">
            {formlabel for='uploadZip' __text='Upload zip' cssClass=''}<br />{* break required for Google Chrome *}
            {formuploadinput group='track' id='uploadZip' mandatory=false readOnly=false cssClass=' validate-upload' }
            <span class="z-formnote"><a id="resetUploadZipVal" href="javascript:void(0);" class="z-hide" style="clear:left;">{gt text='Reset to empty value'}</a></span>
            
                <span class="z-formnote">{gt text='Allowed file extensions:'} <span id="uploadZipFileExtensions">zip</span></span>
            <span class="z-formnote">{gt text='Allowed file size:'} {'1024000'|musoundGetFileSize:'':false:false}</span>
            {if $mode ne 'create'}
                {if $track.uploadZip ne ''}
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
            {/if}
            {musoundValidationError id='uploadZip' class='validate-upload'}
        </div>
    </fieldset>
    
    {include file='admin/album/include_selectEditOne.tpl' group='track' alias='album' aliasReverse='track' mandatory=false idPrefix='musoundTrack_Album' linkingItem=$track displayMode='dropdown' allowEditing=true}
    {if $mode ne 'create'}
        {include file='admin/include_standardfields_edit.tpl' obj=$track}
    {/if}
    
    {* include display hooks *}
    {if $mode ne 'create'}
        {assign var='hookId' value=$track.id}
        {notifydisplayhooks eventname='musound.ui_hooks.tracks.form_edit' id=$hookId assign='hooks'}
    {else}
        {notifydisplayhooks eventname='musound.ui_hooks.tracks.form_edit' id=null assign='hooks'}
    {/if}
    {if is_array($hooks) && count($hooks)}
        {foreach key='providerArea' item='hook' from=$hooks}
            <fieldset>
                {$hook}
            </fieldset>
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
        {assign var='actionIdCapital' value=$action.id|@ucwords}
        {gt text=$action.title assign='actionTitle'}
        {*gt text=$action.description assign='actionDescription'*}{* TODO: formbutton could support title attributes *}
        {if $action.id eq 'delete'}
            {gt text='Really delete this track?' assign='deleteConfirmMsg'}
            {formbutton id="btn`$actionIdCapital`" commandName=$action.id text=$actionTitle class=$action.buttonClass confirmMessage=$deleteConfirmMsg}
        {else}
            {formbutton id="btn`$actionIdCapital`" commandName=$action.id text=$actionTitle class=$action.buttonClass}
        {/if}
    {/foreach}
        {formbutton id='btnCancel' commandName='cancel' __text='Cancel' class='z-bt-cancel'}
    </div>
    {/musoundFormFrame}
{/form}
</div>
{include file='admin/footer.tpl'}

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

        musoundAddCommonValidationRules('track', '{{if $mode ne 'create'}}{{$track.id}}{{/if}}');
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
        musoundInitUploadField('uploadTrack');
        musoundInitUploadField('uploadZip');
    });

/* ]]> */
</script>
