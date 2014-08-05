'use strict';

var currentMUSoundEditor = null;
var currentMUSoundInput = null;

/**
 * Returns the attributes used for the popup window. 
 * @return {String}
 */
function getPopupAttributes()
{
    var pWidth, pHeight;

    pWidth = screen.width * 0.75;
    pHeight = screen.height * 0.66;

    return 'width=' + pWidth + ',height=' + pHeight + ',scrollbars,resizable';
}

/**
 * Open a popup window with the finder triggered by a Xinha button.
 */
function MUSoundFinderXinha(editor, musoundURL)
{
    var popupAttributes;

    // Save editor for access in selector window
    currentMUSoundEditor = editor;

    popupAttributes = getPopupAttributes();
    window.open(musoundURL, '', popupAttributes);
}

/**
 * Open a popup window with the finder triggered by a CKEditor button.
 */
function MUSoundFinderCKEditor(editor, musoundURL)
{
    // Save editor for access in selector window
    currentMUSoundEditor = editor;

    editor.popup(
        Zikula.Config.baseURL + Zikula.Config.entrypoint + '?module=MUSound&type=external&func=finder&editor=ckeditor',
        /*width*/ '80%', /*height*/ '70%',
        'location=no,menubar=no,toolbar=no,dependent=yes,minimizable=no,modal=yes,alwaysRaised=yes,resizable=yes,scrollbars=yes'
    );
}



var musound = {};

musound.finder = {};

musound.finder.onLoad = function (baseId, selectedId)
{
    $$('div.categoryselector select').invoke('observe', 'change', musound.finder.onParamChanged);
    $('mUSoundSort').observe('change', musound.finder.onParamChanged);
    $('mUSoundSortDir').observe('change', musound.finder.onParamChanged);
    $('mUSoundPageSize').observe('change', musound.finder.onParamChanged);
    $('mUSoundSearchGo').observe('click', musound.finder.onParamChanged);
    $('mUSoundSearchGo').observe('keypress', musound.finder.onParamChanged);
    $('mUSoundSubmit').addClassName('z-hide');
    $('mUSoundCancel').observe('click', musound.finder.handleCancel);
};

musound.finder.onParamChanged = function ()
{
    $('mUSoundSelectorForm').submit();
};

musound.finder.handleCancel = function ()
{
    var editor, w;

    editor = $F('editorName');
    if (editor === 'xinha') {
        w = parent.window;
        window.close();
        w.focus();
    } else if (editor === 'tinymce') {
        musoundClosePopup();
    } else if (editor === 'ckeditor') {
        musoundClosePopup();
    } else {
        alert('Close Editor: ' + editor);
    }
};


function getPasteSnippet(mode, itemId)
{
    var itemUrl, itemTitle, itemDescription, pasteMode;

    itemUrl = $F('url' + itemId);
    itemTitle = $F('title' + itemId);
    itemDescription = $F('desc' + itemId);
    pasteMode = $F('mUSoundPasteAs');

    if (pasteMode === '2' || pasteMode !== '1') {
        return itemId;
    }

    // return link to item
    if (mode === 'url') {
        // plugin mode
        return itemUrl;
    }

    // editor mode
    return '<a href="' + itemUrl + '" title="' + itemDescription + '">' + itemTitle + '</a>';
}


// User clicks on "select item" button
musound.finder.selectItem = function (itemId)
{
    var editor, html;

    editor = $F('editorName');
    if (editor === 'xinha') {
        if (window.opener.currentMUSoundEditor !== null) {
            html = getPasteSnippet('html', itemId);

            window.opener.currentMUSoundEditor.focusEditor();
            window.opener.currentMUSoundEditor.insertHTML(html);
        } else {
            html = getPasteSnippet('url', itemId);
            var currentInput = window.opener.currentMUSoundInput;

            if (currentInput.tagName === 'INPUT') {
                // Simply overwrite value of input elements
                currentInput.value = html;
            } else if (currentInput.tagName === 'TEXTAREA') {
                // Try to paste into textarea - technique depends on environment
                if (typeof document.selection !== 'undefined') {
                    // IE: Move focus to textarea (which fortunately keeps its current selection) and overwrite selection
                    currentInput.focus();
                    window.opener.document.selection.createRange().text = html;
                } else if (typeof currentInput.selectionStart !== 'undefined') {
                    // Firefox: Get start and end points of selection and create new value based on old value
                    var startPos = currentInput.selectionStart;
                    var endPos = currentInput.selectionEnd;
                    currentInput.value = currentInput.value.substring(0, startPos)
                                        + html
                                        + currentInput.value.substring(endPos, currentInput.value.length);
                } else {
                    // Others: just append to the current value
                    currentInput.value += html;
                }
            }
        }
    } else if (editor === 'tinymce') {
        html = getPasteSnippet('html', itemId);
        window.opener.tinyMCE.activeEditor.execCommand('mceInsertContent', false, html);
        // other tinymce commands: mceImage, mceInsertLink, mceReplaceContent, see http://www.tinymce.com/wiki.php/Command_identifiers
    } else if (editor === 'ckeditor') {
        if (window.opener.currentMUSoundEditor !== null) {
            html = getPasteSnippet('html', itemId);

            window.opener.currentMUSoundEditor.insertHtml(html);
        }
    } else {
        alert('Insert into Editor: ' + editor);
    }
    musoundClosePopup();
};


function musoundClosePopup()
{
    window.opener.focus();
    window.close();
}




//=============================================================================
// MUSound item selector for Forms
//=============================================================================

musound.itemSelector = {};
musound.itemSelector.items = {};
musound.itemSelector.baseId = 0;
musound.itemSelector.selectedId = 0;

musound.itemSelector.onLoad = function (baseId, selectedId)
{
    musound.itemSelector.baseId = baseId;
    musound.itemSelector.selectedId = selectedId;

    // required as a changed object type requires a new instance of the item selector plugin
    $('mUSoundObjectType').observe('change', musound.itemSelector.onParamChanged);

    if ($(baseId + '_catidMain') != undefined) {
        $(baseId + '_catidMain').observe('change', musound.itemSelector.onParamChanged);
    } else if ($(baseId + '_catidsMain') != undefined) {
        $(baseId + '_catidsMain').observe('change', musound.itemSelector.onParamChanged);
    }
    $(baseId + 'Id').observe('change', musound.itemSelector.onItemChanged);
    $(baseId + 'Sort').observe('change', musound.itemSelector.onParamChanged);
    $(baseId + 'SortDir').observe('change', musound.itemSelector.onParamChanged);
    $('mUSoundSearchGo').observe('click', musound.itemSelector.onParamChanged);
    $('mUSoundSearchGo').observe('keypress', musound.itemSelector.onParamChanged);

    musound.itemSelector.getItemList();
};

musound.itemSelector.onParamChanged = function ()
{
    $('ajax_indicator').removeClassName('z-hide');

    musound.itemSelector.getItemList();
};

musound.itemSelector.getItemList = function ()
{
    var baseId, params, request;

    baseId = musound.itemSelector.baseId;
    params = 'ot=' + baseId + '&';
    if ($(baseId + '_catidMain') != undefined) {
        params += 'catidMain=' + $F(baseId + '_catidMain') + '&';
    } else if ($(baseId + '_catidsMain') != undefined) {
        params += 'catidsMain=' + $F(baseId + '_catidsMain') + '&';
    }
    params += 'sort=' + $F(baseId + 'Sort') + '&' +
              'sortdir=' + $F(baseId + 'SortDir') + '&' +
              'searchterm=' + $F(baseId + 'SearchTerm');

    request = new Zikula.Ajax.Request(
        Zikula.Config.baseURL + 'ajax.php?module=MUSound&func=getItemListFinder',
        {
            method: 'post',
            parameters: params,
            onFailure: function(req) {
                Zikula.showajaxerror(req.getMessage());
            },
            onSuccess: function(req) {
                var baseId;
                baseId = musound.itemSelector.baseId;
                musound.itemSelector.items[baseId] = req.getData();
                $('ajax_indicator').addClassName('z-hide');
                musound.itemSelector.updateItemDropdownEntries();
                musound.itemSelector.updatePreview();
            }
        }
    );
};

musound.itemSelector.updateItemDropdownEntries = function ()
{
    var baseId, itemSelector, items, i, item;

    baseId = musound.itemSelector.baseId;
    itemSelector = $(baseId + 'Id');
    itemSelector.length = 0;

    items = musound.itemSelector.items[baseId];
    for (i = 0; i < items.length; ++i) {
        item = items[i];
        itemSelector.options[i] = new Option(item.title, item.id, false);
    }

    if (musound.itemSelector.selectedId > 0) {
        $(baseId + 'Id').value = musound.itemSelector.selectedId;
    }
};

musound.itemSelector.updatePreview = function ()
{
    var baseId, items, selectedElement, i;

    baseId = musound.itemSelector.baseId;
    items = musound.itemSelector.items[baseId];

    $(baseId + 'PreviewContainer').addClassName('z-hide');

    if (items.length === 0) {
        return;
    }

    selectedElement = items[0];
    if (musound.itemSelector.selectedId > 0) {
        for (var i = 0; i < items.length; ++i) {
            if (items[i].id === musound.itemSelector.selectedId) {
                selectedElement = items[i];
                break;
            }
        }
    }

    if (selectedElement !== null) {
        $(baseId + 'PreviewContainer')
            .update(window.atob(selectedElement.previewInfo))
            .removeClassName('z-hide');
    }
};

musound.itemSelector.onItemChanged = function ()
{
    var baseId, itemSelector, preview;

    baseId = musound.itemSelector.baseId;
    itemSelector = $(baseId + 'Id');
    preview = window.atob(musound.itemSelector.items[baseId][itemSelector.selectedIndex].previewInfo);

    $(baseId + 'PreviewContainer').update(preview);
    musound.itemSelector.selectedId = $F(baseId + 'Id');
};
