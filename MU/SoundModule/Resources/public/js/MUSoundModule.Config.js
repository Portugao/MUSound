'use strict';

function soundToggleShrinkSettings(fieldName) {
    var idSuffix = fieldName.replace('musoundmodule_appsettings_', '');
    jQuery('#shrinkDetails' + idSuffix).toggleClass('hidden', !jQuery('#musoundmodule_appsettings_enableShrinkingFor' + idSuffix).prop('checked'));
}

jQuery(document).ready(function() {
    jQuery('.shrink-enabler').each(function (index) {
        jQuery(this).bind('click keyup', function (event) {
            soundToggleShrinkSettings(jQuery(this).attr('id').replace('enableShrinkingFor', ''));
        });
        soundToggleShrinkSettings(jQuery(this).attr('id').replace('enableShrinkingFor', ''));
    });
});
