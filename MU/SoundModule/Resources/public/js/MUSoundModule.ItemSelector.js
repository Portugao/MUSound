'use strict';

var mUSoundModule = {};

mUSoundModule.itemSelector = {};
mUSoundModule.itemSelector.items = {};
mUSoundModule.itemSelector.baseId = 0;
mUSoundModule.itemSelector.selectedId = 0;

mUSoundModule.itemSelector.onLoad = function (baseId, selectedId)
{
    mUSoundModule.itemSelector.baseId = baseId;
    mUSoundModule.itemSelector.selectedId = selectedId;

    // required as a changed object type requires a new instance of the item selector plugin
    jQuery('#mUSoundModuleObjectType').change(mUSoundModule.itemSelector.onParamChanged);

    jQuery('#' + baseId + '_catidMain').change(mUSoundModule.itemSelector.onParamChanged);
    jQuery('#' + baseId + '_catidsMain').change(mUSoundModule.itemSelector.onParamChanged);
    jQuery('#' + baseId + 'Id').change(mUSoundModule.itemSelector.onItemChanged);
    jQuery('#' + baseId + 'Sort').change(mUSoundModule.itemSelector.onParamChanged);
    jQuery('#' + baseId + 'SortDir').change(mUSoundModule.itemSelector.onParamChanged);
    jQuery('#mUSoundModuleSearchGo').click(mUSoundModule.itemSelector.onParamChanged);
    jQuery('#mUSoundModuleSearchGo').keypress(mUSoundModule.itemSelector.onParamChanged);

    mUSoundModule.itemSelector.getItemList();
};

mUSoundModule.itemSelector.onParamChanged = function ()
{
    jQuery('#ajaxIndicator').removeClass('hidden');

    mUSoundModule.itemSelector.getItemList();
};

mUSoundModule.itemSelector.getItemList = function ()
{
    var baseId;
    var params;

    baseId = mUSoundModule.itemSelector.baseId;
    params = {
        ot: baseId,
        sort: jQuery('#' + baseId + 'Sort').val(),
        sortdir: jQuery('#' + baseId + 'SortDir').val(),
        q: jQuery('#' + baseId + 'SearchTerm').val()
    }
    if (jQuery('#' + baseId + '_catidMain').length > 0) {
        params[catidMain] = jQuery('#' + baseId + '_catidMain').val();
    } else if (jQuery('#' + baseId + '_catidsMain').length > 0) {
        params[catidsMain] = jQuery('#' + baseId + '_catidsMain').val();
    }

    jQuery.getJSON(Routing.generate('musoundmodule_ajax_getitemlistfinder'), params, function( data ) {
        var baseId;

        baseId = mUSoundModule.itemSelector.baseId;
        mUSoundModule.itemSelector.items[baseId] = data;
        jQuery('#ajaxIndicator').addClass('hidden');
        mUSoundModule.itemSelector.updateItemDropdownEntries();
        mUSoundModule.itemSelector.updatePreview();
    });
};

mUSoundModule.itemSelector.updateItemDropdownEntries = function ()
{
    var baseId, itemSelector, items, i, item;

    baseId = mUSoundModule.itemSelector.baseId;
    itemSelector = jQuery('#' + baseId + 'Id');
    itemSelector.length = 0;

    items = mUSoundModule.itemSelector.items[baseId];
    for (i = 0; i < items.length; ++i) {
        item = items[i];
        itemSelector.get(0).options[i] = new Option(item.title, item.id, false);
    }

    if (mUSoundModule.itemSelector.selectedId > 0) {
        jQuery('#' + baseId + 'Id').val(mUSoundModule.itemSelector.selectedId);
    }
};

mUSoundModule.itemSelector.updatePreview = function ()
{
    var baseId, items, selectedElement, i;

    baseId = mUSoundModule.itemSelector.baseId;
    items = mUSoundModule.itemSelector.items[baseId];

    jQuery('#' + baseId + 'PreviewContainer').addClass('hidden');

    if (items.length === 0) {
        return;
    }

    selectedElement = items[0];
    if (mUSoundModule.itemSelector.selectedId > 0) {
        for (var i = 0; i < items.length; ++i) {
            if (items[i].id == mUSoundModule.itemSelector.selectedId) {
                selectedElement = items[i];
                break;
            }
        }
    }

    if (null !== selectedElement) {
        jQuery('#' + baseId + 'PreviewContainer')
            .html(window.atob(selectedElement.previewInfo))
            .removeClass('hidden');
        mUSoundInitImageViewer();
    }
};

mUSoundModule.itemSelector.onItemChanged = function ()
{
    var baseId, itemSelector, preview;

    baseId = mUSoundModule.itemSelector.baseId;
    itemSelector = jQuery('#' + baseId + 'Id').get(0);
    preview = window.atob(mUSoundModule.itemSelector.items[baseId][itemSelector.selectedIndex].previewInfo);

    jQuery('#' + baseId + 'PreviewContainer').html(preview);
    mUSoundModule.itemSelector.selectedId = jQuery('#' + baseId + 'Id').val();
    mUSoundInitImageViewer();
};

jQuery(document).ready(function() {
    var infoElem;

    infoElem = jQuery('#itemSelectorInfo');
    if (infoElem.length == 0) {
        return;
    }

    mUSoundModule.itemSelector.onLoad(infoElem.data('base-id'), infoElem.data('selected-id'));
});
