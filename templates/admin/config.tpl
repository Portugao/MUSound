{* purpose of this template: module configuration page *}
{include file='admin/header.tpl'}
<div class="musound-config">
    {gt text='Settings' assign='templateTitle'}
    {pagesetvar name='title' value=$templateTitle}
    <div class="z-admin-content-pagetitle">
        {icon type='config' size='small' __alt='Settings'}
        <h3>{$templateTitle}</h3>
    </div>

    {form cssClass='z-form'}
        {* add validation summary and a <div> element for styling the form *}
        {musoundFormFrame}
            {formsetinitialfocus inputId='pageSizeCollection'}
            {formtabbedpanelset}
                {gt text='General' assign='tabTitle'}
                {formtabbedpanel title=$tabTitle}
                    <fieldset>
                        <legend>{$tabTitle}</legend>
                    
                        <p class="z-confirmationmsg">{gt text='Here you can manage all basic settings for this application.'}</p>
                    
                        <div class="z-formrow">
                            {formlabel for='pageSizeCollection' __text='Page size collection' cssClass=''}
                            {formintinput id='pageSizeCollection' group='config' maxLength=255 __title='Enter the page size collection. Only digits are allowed.'}
                        </div>
                        <div class="z-formrow">
                            {formlabel for='pagesizeAlbum' __text='Pagesize album' cssClass=''}
                            {formintinput id='pagesizeAlbum' group='config' maxLength=255 __title='Enter the pagesize album. Only digits are allowed.'}
                        </div>
                        <div class="z-formrow">
                            {formlabel for='pagesizeTrack' __text='Pagesize track' cssClass=''}
                            {formintinput id='pagesizeTrack' group='config' maxLength=255 __title='Enter the pagesize track. Only digits are allowed.'}
                        </div>
                        <div class="z-formrow">
                            {formlabel for='maxSizeCover' __text='Max size cover' cssClass=''}
                            {formintinput id='maxSizeCover' group='config' maxLength=255 __title='Enter the max size cover. Only digits are allowed.'}
                        </div>
                        <div class="z-formrow">
                            {formlabel for='maxSizeTrack' __text='Max size track' cssClass=''}
                            {formintinput id='maxSizeTrack' group='config' maxLength=255 __title='Enter the max size track. Only digits are allowed.'}
                        </div>
                        <div class="z-formrow">
                            {formlabel for='maxSizeZip' __text='Max size zip' cssClass=''}
                            {formintinput id='maxSizeZip' group='config' maxLength=255 __title='Enter the max size zip. Only digits are allowed.'}
                        </div>
                        <div class="z-formrow">
                            {formlabel for='allowedExtensionCover' __text='Allowed extension cover' cssClass=''}
                            {formtextinput id='allowedExtensionCover' group='config' maxLength=255 __title='Enter the allowed extension cover.'}
                        </div>
                        <div class="z-formrow">
                            {formlabel for='allowedExtensionTrack' __text='Allowed extension track' cssClass=''}
                            {formtextinput id='allowedExtensionTrack' group='config' maxLength=255 __title='Enter the allowed extension track.'}
                            <span class="z-formnote z-warningmsg">{gt text='Only mp3 supported at the moment.'}</span> 
                        </div>
                        <div class="z-formrow">
                            {formlabel for='supportedModules' __text='Supported modules' cssClass=''}
                            {formtextinput id='supportedModules' group='config' maxLength=255 __title='Enter the supported modules.'}
                        </div>
                        <div class="z-formrow">
                            {formlabel for='useStandard' __text='Use standard' cssClass=''}
                            {formcheckbox id='useStandard' group='config'}
                        </div>
                        <div class="z-formrow">
                            {formlabel for='orderOfCollections' __text='Order of collections' cssClass=''}
                            {formdropdownlist id='orderOfCollections' group='config' __title='Choose the order of collections'}
                        </div>
                        <div class="z-formrow">
                            {formlabel for='orderOfAlbums' __text='Order of albums' cssClass=''}
                            {formdropdownlist id='orderOfAlbums' group='config' __title='Choose the order of albums'}
                        </div>
                    </fieldset>
                {/formtabbedpanel}
                {gt text='Thumbnails view' assign='tabTitle'}
                {formtabbedpanel title=$tabTitle}
                    <fieldset>
                        <legend>{$tabTitle}</legend>
                    
                    
                        <div class="z-formrow">
                            {formlabel for='backendWidth' __text='Backend width' cssClass=''}
                            {formintinput id='backendWidth' group='config' maxLength=255 __title='Enter the backend width. Only digits are allowed.'}
                        </div>
                        <div class="z-formrow">
                            {formlabel for='backendHeight' __text='Backend height' cssClass=''}
                            {formintinput id='backendHeight' group='config' maxLength=255 __title='Enter the backend height. Only digits are allowed.'}
                        </div>
                        <div class="z-formrow">
                            {formlabel for='frontendWidth' __text='Frontend width' cssClass=''}
                            {formintinput id='frontendWidth' group='config' maxLength=255 __title='Enter the frontend width. Only digits are allowed.'}
                        </div>
                        <div class="z-formrow">
                            {formlabel for='frontendHeight' __text='Frontend height' cssClass=''}
                            {formintinput id='frontendHeight' group='config' maxLength=255 __title='Enter the frontend height. Only digits are allowed.'}
                        </div>
                    </fieldset>
                {/formtabbedpanel}
                {gt text='Thumbnails display' assign='tabTitle'}
                {formtabbedpanel title=$tabTitle}
                    <fieldset>
                        <legend>{$tabTitle}</legend>
                    
                    
                        <div class="z-formrow">
                            {formlabel for='backendWidth' __text='Backend width' cssClass=''}
                            {formintinput id='backendWidth' group='config' maxLength=255 __title='Enter the backend width. Only digits are allowed.'}
                        </div>
                        <div class="z-formrow">
                            {formlabel for='backendHeight' __text='Backend height' cssClass=''}
                            {formintinput id='backendHeight' group='config' maxLength=255 __title='Enter the backend height. Only digits are allowed.'}
                        </div>
                        <div class="z-formrow">
                            {formlabel for='frontendWidth' __text='Frontend width' cssClass=''}
                            {formintinput id='frontendWidth' group='config' maxLength=255 __title='Enter the frontend width. Only digits are allowed.'}
                        </div>
                        <div class="z-formrow">
                            {formlabel for='frontendHeight' __text='Frontend height' cssClass=''}
                            {formintinput id='frontendHeight' group='config' maxLength=255 __title='Enter the frontend height. Only digits are allowed.'}
                        </div>
                    </fieldset>
                {/formtabbedpanel}
                {gt text='Moderation' assign='tabTitle'}
                {formtabbedpanel title=$tabTitle}
                    <fieldset>
                        <legend>{$tabTitle}</legend>
                    
                        <p class="z-confirmationmsg">{gt text='Here you can assign moderation groups for enhanced workflow actions.'|nl2br}</p>
                    
                        <div class="z-formrow">
                            {gt text='Used to determine moderator user accounts for sending email notifications.' assign='toolTip'}
                            {formlabel for='moderationGroupForAlbums' __text='Moderation group for albums' cssClass='musound-form-tooltips ' title=$toolTip}
                            {formdropdownlist id='moderationGroupForAlbums' group='config' __title='Choose the moderation group for albums'}
                        </div>
                    </fieldset>
                {/formtabbedpanel}
                {gt text='Images' assign='tabTitle'}
                {formtabbedpanel title=$tabTitle}
                    <fieldset>
                        <legend>{$tabTitle}</legend>
                    
                        <p class="z-confirmationmsg">{gt text='Here you can define shrinking behaviour for huge images.'|nl2br}</p>
                    
                        <div class="z-formrow">
                            {gt text='Whether to enable shrinking to maximum image dimensions. The original image is not stored.' assign='toolTip'}
                            {formlabel for='enableShrinkingForAlbumUploadCover' __text='Enable shrinking for album upload cover' cssClass='musound-form-tooltips ' title=$toolTip}
                            {formcheckbox id='enableShrinkingForAlbumUploadCover' group='config' cssClass='shrink-enabler'}
                        </div>
                        <div class="z-formrow shrinkdimension-albumuploadcover">
                            {gt text='The maximum image width.' assign='toolTip'}
                            {formlabel for='shrinkWidthAlbumUploadCover' __text='Shrink width album upload cover' cssClass='musound-form-tooltips ' title=$toolTip}
                            <div>
                                {formintinput id='shrinkWidthAlbumUploadCover' group='config' size=8 maxLength=4 __title='themaximumimagewidth'}
                                 {gt text='pixels'}
                            </div>
                        </div>
                        <div class="z-formrow shrinkdimension-albumuploadcover">
                            {gt text='The maximum image height.' assign='toolTip'}
                            {formlabel for='shrinkHeightAlbumUploadCover' __text='Shrink height album upload cover' cssClass='musound-form-tooltips ' title=$toolTip}
                            <div>
                                {formintinput id='shrinkHeightAlbumUploadCover' group='config' size=8 maxLength=4 __title='themaximumimageheight'}
                                 {gt text='pixels'}
                            </div>
                        </div>
                    </fieldset>
                {/formtabbedpanel}
            {/formtabbedpanelset}

            <div class="z-buttons z-formbuttons">
                {formbutton commandName='save' __text='Update configuration' class='z-bt-save'}
                {formbutton commandName='cancel' __text='Cancel' class='z-bt-cancel'}
            </div>
        {/musoundFormFrame}
    {/form}
</div>
{include file='admin/footer.tpl'}
<script type="text/javascript">
/* <![CDATA[ */
    function musoundToggleShrinkSettings(fieldName)
    {
        $$('.shrinkdimension-' + fieldName.toLowerCase()).each(function(elem, index) {
            if ($('enableShrinkingFor' + fieldName).checked == true) {
                elem.removeClassName('z-hide');
            } else {
                elem.addClassName('z-hide');
            }
        });
    }

    document.observe('dom:loaded', function() {
        Zikula.UI.Tooltips($$('.musound-form-tooltips'));
        $$('.shrink-enabler').each(function(elem, index) {
            elem.observe('click', musoundToggleShrinkSettings(elem.getAttribute('id').replace('enableShrinkingFor', '')));
            elem.observe('keyup', musoundToggleShrinkSettings(elem.getAttribute('id').replace('enableShrinkingFor', '')));
            musoundToggleShrinkSettings(elem.getAttribute('id').replace('enableShrinkingFor', ''));
        });
    });
/* ]]> */
</script>
