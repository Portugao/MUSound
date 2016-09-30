'use strict';

var currentMUSoundEditor = null;
var currentMUSoundInput = null;

/**
 * Returns the attributes used for the popup window. 
 * @return {String}
 */
function getMUSoundPopupAttributes()
{
    var pWidth, pHeight;

    pWidth = screen.width * 0.75;
    pHeight = screen.height * 0.66;

    return 'width=' + pWidth + ',height=' + pHeight + ',scrollbars,resizable';
}

/**
 * Open a popup window with the finder triggered by a Xinha button.
 */
function MUSoundFinderXinha(editor, musoundUrl)
{
    var popupAttributes;

    // Save editor for access in selector window
    currentMUSoundEditor = editor;

    popupAttributes = getMUSoundPopupAttributes();
    window.open(musoundUrl, '', popupAttributes);
}

/**
 * Open a popup window with the finder triggered by a CKEditor button.
 */
function MUSoundFinderCKEditor(editor, musoundUrl)
{
    // Save editor for access in selector window
    currentMUSoundEditor = editor;

    editor.popup(
        Zikula.Config.baseURL + Zikula.Config.entrypoint + '?module=MUSound&type=external&func=finder&editor=ckeditor',
        /*width*/ '80%', /*height*/ '70%',
        'location=no,menubar=no,toolbar=no,dependent=yes,minimizable=no,modal=yes,alwaysRaised=yes,resizable=yes,scrollbars=yes'
    );
}


var mUSound = {};

mUSound.finder = {};

mUSound.finder.onLoad = function (baseId, selectedId)
{
    $$('div.category-selector select').invoke('observe', 'change', mUSound.finder.onParamChanged);
    $('mUSoundSort').observe('change', mUSound.finder.onParamChanged);
    $('mUSoundSortDir').observe('change', mUSound.finder.onParamChanged);
    $('mUSoundPageSize').observe('change', mUSound.finder.onParamChanged);
    $('mUSoundSearchGo').observe('click', mUSound.finder.onParamChanged);
    $('mUSoundSearchGo').observe('keypress', mUSound.finder.onParamChanged);
    $('mUSoundSubmit').addClassName('z-hide');
    $('mUSoundCancel').observe('click', mUSound.finder.handleCancel);
};

mUSound.finder.onParamChanged = function ()
{
    $('mUSoundSelectorForm').submit();
};

mUSound.finder.handleCancel = function ()
{
    var editor, w;

    editor = $F('editorName');
    if ('xinha' === editor) {
        w = parent.window;
        window.close();
        w.focus();
    } else if (editor === 'tinymce') {
        mUMUSoundClosePopup();
    } else if (editor === 'ckeditor') {
        mUMUSoundClosePopup();
    } else {
        alert('Close Editor: ' + editor);
    }
};


function mUMUSoundGetPasteSnippet(mode, itemId)
{
    var quoteFinder, itemUrl, itemTitle, itemDescription, pasteMode;

    quoteFinder = new RegExp('"', 'g');
    itemUrl = $F('url' + itemId).replace(quoteFinder, '');
    itemTitle = $F('title' + itemId).replace(quoteFinder, '');
    itemDescription = $F('desc' + itemId).replace(quoteFinder, '');
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
mUSound.finder.selectItem = function (itemId)
{
    var editor, html;

    editor = $F('editorName');
    if ('xinha' === editor) {
        if (null !== window.opener.currentMUSoundEditor) {
            html = mUMUSoundGetPasteSnippet('html', itemId);

            window.opener.currentMUSoundEditor.focusEditor();
            window.opener.currentMUSoundEditor.insertHTML(html);
        } else {
            html = mUMUSoundGetPasteSnippet('url', itemId);
            var currentInput = window.opener.currentMUSoundInput;

            if ('INPUT' === currentInput.tagName) {
                // Simply overwrite value of input elements
                currentInput.value = html;
            } else if ('TEXTAREA' === currentInput.tagName) {
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
    } else if ('tinymce' === editor) {
        html = mUMUSoundGetPasteSnippet('html', itemId);
        tinyMCE.activeEditor.execCommand('mceInsertContent', false, html);
        // other tinymce commands: mceImage, mceInsertLink, mceReplaceContent, see http://www.tinymce.com/wiki.php/Command_identifiers
    } else if ('ckeditor' === editor) {
        if (null !== window.opener.currentMUSoundEditor) {
            html = mUMUSoundGetPasteSnippet('html', itemId);

            window.opener.currentMUSoundEditor.insertHtml(html);
        }
    } else {
        alert('Insert into Editor: ' + editor);
    }
    mUMUSoundClosePopup();
};

function mUMUSoundClosePopup()
{
    window.opener.focus();
    window.close();
}




//=============================================================================
// MUSound item selector for Forms
//=============================================================================

mUSound.itemSelector = {};
mUSound.itemSelector.items = {};
mUSound.itemSelector.baseId = 0;
mUSound.itemSelector.selectedId = 0;

mUSound.itemSelector.onLoad = function (baseId, selectedId)
{
    mUSound.itemSelector.baseId = baseId;
    mUSound.itemSelector.selectedId = selectedId;

    // required as a changed object type requires a new instance of the item selector plugin
    $('mUSoundObjectType').observe('change', mUSound.itemSelector.onParamChanged);

    if ($(baseId + '_catidMain') != undefined) {
        $(baseId + '_catidMain').observe('change', mUSound.itemSelector.onParamChanged);
    } else if ($(baseId + '_catidsMain') != undefined) {
        $(baseId + '_catidsMain').observe('change', mUSound.itemSelector.onParamChanged);
    }
    $(baseId + 'Id').observe('change', mUSound.itemSelector.onItemChanged);
    $(baseId + 'Sort').observe('change', mUSound.itemSelector.onParamChanged);
    $(baseId + 'SortDir').observe('change', mUSound.itemSelector.onParamChanged);
    $('mUSoundSearchGo').observe('click', mUSound.itemSelector.onParamChanged);
    $('mUSoundSearchGo').observe('keypress', mUSound.itemSelector.onParamChanged);

    mUSound.itemSelector.getItemList();
};

mUSound.itemSelector.onParamChanged = function ()
{
    $('ajax_indicator').removeClassName('z-hide');

    mUSound.itemSelector.getItemList();
};

mUSound.itemSelector.getItemList = function ()
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
              'q=' + $F(baseId + 'SearchTerm');

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
                baseId = mUSound.itemSelector.baseId;
                mUSound.itemSelector.items[baseId] = req.getData();
                $('ajax_indicator').addClassName('z-hide');
                mUSound.itemSelector.updateItemDropdownEntries();
                mUSound.itemSelector.updatePreview();
            }
        }
    );
};

mUSound.itemSelector.updateItemDropdownEntries = function ()
{
    var baseId, itemSelector, items, i, item;

    baseId = mUSound.itemSelector.baseId;
    itemSelector = $(baseId + 'Id');
    itemSelector.length = 0;

    items = mUSound.itemSelector.items[baseId];
    for (i = 0; i < items.length; ++i) {
        item = items[i];
        itemSelector.options[i] = new Option(item.title, item.id, false);
    }

    if (mUSound.itemSelector.selectedId > 0) {
        $(baseId + 'Id').value = mUSound.itemSelector.selectedId;
    }
};

mUSound.itemSelector.updatePreview = function ()
{
    var baseId, items, selectedElement, i;

    baseId = mUSound.itemSelector.baseId;
    items = mUSound.itemSelector.items[baseId];

    $(baseId + 'PreviewContainer').addClassName('z-hide');

    if (items.length === 0) {
        return;
    }

    selectedElement = items[0];
    if (mUSound.itemSelector.selectedId > 0) {
        for (var i = 0; i < items.length; ++i) {
            if (items[i].id === mUSound.itemSelector.selectedId) {
                selectedElement = items[i];
                break;
            }
        }
    }

    if (null !== selectedElement) {
        $(baseId + 'PreviewContainer')
            .update(window.atob(selectedElement.previewInfo))
            .removeClassName('z-hide');
    }
};

mUSound.itemSelector.onItemChanged = function ()
{
    var baseId, itemSelector, preview;

    baseId = mUSound.itemSelector.baseId;
    itemSelector = $(baseId + 'Id');
    preview = window.atob(mUSound.itemSelector.items[baseId][itemSelector.selectedIndex].previewInfo);

    $(baseId + 'PreviewContainer').update(preview);
    mUSound.itemSelector.selectedId = $F(baseId + 'Id');
};
