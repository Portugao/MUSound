{* Purpose of this template: Display a popup selector of tracks for scribite integration *}
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="{lang}" lang="{lang}">
<head>
    <title>{gt text='Search and select track'}</title>
    <link type="text/css" rel="stylesheet" href="{$baseurl}style/core.css" />
    <link type="text/css" rel="stylesheet" href="{$baseurl}modules/MUSound/style/style.css" />
    <link type="text/css" rel="stylesheet" href="{$baseurl}modules/MUSound/style/finder.css" />
    {assign var='ourEntry' value=$modvars.ZConfig.entrypoint}
    <script type="text/javascript">/* <![CDATA[ */
        if (typeof(Zikula) == 'undefined') {var Zikula = {};}
        Zikula.Config = {'entrypoint': '{{$ourEntry|default:'index.php'}}', 'baseURL': '{{$baseurl}}'}; /* ]]> */
    </script>
    <script type="text/javascript" src="{$baseurl}javascript/ajax/proto_scriptaculous.combined.min.js"></script>
    <script type="text/javascript" src="{$baseurl}javascript/helpers/Zikula.js"></script>
    <script type="text/javascript" src="{$baseurl}javascript/livepipe/livepipe.combined.min.js"></script>
    <script type="text/javascript" src="{$baseurl}javascript/helpers/Zikula.UI.js"></script>
    <script type="text/javascript" src="{$baseurl}javascript/helpers/Zikula.ImageViewer.js"></script>
    <script type="text/javascript" src="{$baseurl}modules/MUSound/javascript/MUSound_finder.js"></script>
    {if $editorName eq 'tinymce'}
        <script type="text/javascript" src="{$baseurl}modules/Scribite/includes/tinymce/tiny_mce_popup.js"></script>
    {/if}
</head>
<body>
    <p>{gt text='Switch to'}:
    <a href="{modurl modname='MUSound' type='external' func='finder' objectType='album' editor=$editorName}" title="{gt text='Search and select album'}">{gt text='Albums'}</a> | 
    <a href="{modurl modname='MUSound' type='external' func='finder' objectType='collection' editor=$editorName}" title="{gt text='Search and select collection'}">{gt text='Collections'}</a>
    </p>
    <form action="{$ourEntry|default:'index.php'}" id="mUSoundSelectorForm" method="get" class="z-form">
    <div>
        <input type="hidden" name="module" value="MUSound" />
        <input type="hidden" name="type" value="external" />
        <input type="hidden" name="func" value="finder" />
        <input type="hidden" name="objectType" value="{$objectType}" />
        <input type="hidden" name="editor" id="editorName" value="{$editorName}" />

        <fieldset>
            <legend>{gt text='Search and select track'}</legend>

            <div class="z-formrow">
                <label for="mUSoundPasteAs">{gt text='Paste as'}:</label>
                <select id="mUSoundPasteAs" name="pasteas">
                    <option value="1">{gt text='Link to the track'}</option>
                    <option value="2">{gt text='ID of track'}</option>
                </select>
            </div>
            <br />

            <div class="z-formrow">
                <label for="mUSoundObjectId">{gt text='Track'}:</label>
                    <div id="musoundItemContainer">
                        <ul>
                        {foreach item='track' from=$items}
                            <li>
                                {assign var='itemId' value=$track.id}
                                <a href="#" onclick="mUSound.finder.selectItem({$itemId})" onkeypress="mUSound.finder.selectItem({$itemId})">{$track->getTitleFromDisplayPattern()}</a>
                                <input type="hidden" id="url{$itemId}" value="{modurl modname='MUSound' type='user' func='display' ot='track'  id=$track.id fqurl=true}" />
                                <input type="hidden" id="title{$itemId}" value="{$track->getTitleFromDisplayPattern()|replace:"\"":""}" />
                                <input type="hidden" id="desc{$itemId}" value="{capture assign='description'}{if $track.description ne ''}{$track.description}{/if}
                                {/capture}{$description|strip_tags|replace:"\"":""}" />
                            </li>
                        {foreachelse}
                            <li>{gt text='No entries found.'}</li>
                        {/foreach}
                        </ul>
                    </div>
            </div>

            <div class="z-formrow">
                <label for="mUSoundSort">{gt text='Sort by'}:</label>
                <select id="mUSoundSort" name="sort" class="z-floatleft" style="width: 100px; margin-right: 10px">
                    <option value="id"{if $sort eq 'id'} selected="selected"{/if}>{gt text='Id'}</option>
                    <option value="title"{if $sort eq 'title'} selected="selected"{/if}>{gt text='Title'}</option>
                    <option value="description"{if $sort eq 'description'} selected="selected"{/if}>{gt text='Description'}</option>
                    <option value="author"{if $sort eq 'author'} selected="selected"{/if}>{gt text='Author'}</option>
                    <option value="uploadTrack"{if $sort eq 'uploadTrack'} selected="selected"{/if}>{gt text='Upload track'}</option>
                    <option value="uploadZip"{if $sort eq 'uploadZip'} selected="selected"{/if}>{gt text='Upload zip'}</option>
                    <option value="pos"{if $sort eq 'pos'} selected="selected"{/if}>{gt text='Pos'}</option>
                    <option value="createdDate"{if $sort eq 'createdDate'} selected="selected"{/if}>{gt text='Creation date'}</option>
                    <option value="createdUserId"{if $sort eq 'createdUserId'} selected="selected"{/if}>{gt text='Creator'}</option>
                    <option value="updatedDate"{if $sort eq 'updatedDate'} selected="selected"{/if}>{gt text='Update date'}</option>
                </select>
                <select id="mUSoundSortDir" name="sortdir" style="width: 100px">
                    <option value="asc"{if $sortdir eq 'asc'} selected="selected"{/if}>{gt text='ascending'}</option>
                    <option value="desc"{if $sortdir eq 'desc'} selected="selected"{/if}>{gt text='descending'}</option>
                </select>
            </div>

            <div class="z-formrow">
                <label for="mUSoundPageSize">{gt text='Page size'}:</label>
                <select id="mUSoundPageSize" name="num" style="width: 50px; text-align: right">
                    <option value="5"{if $pager.itemsperpage eq 5} selected="selected"{/if}>5</option>
                    <option value="10"{if $pager.itemsperpage eq 10} selected="selected"{/if}>10</option>
                    <option value="15"{if $pager.itemsperpage eq 15} selected="selected"{/if}>15</option>
                    <option value="20"{if $pager.itemsperpage eq 20} selected="selected"{/if}>20</option>
                    <option value="30"{if $pager.itemsperpage eq 30} selected="selected"{/if}>30</option>
                    <option value="50"{if $pager.itemsperpage eq 50} selected="selected"{/if}>50</option>
                    <option value="100"{if $pager.itemsperpage eq 100} selected="selected"{/if}>100</option>
                </select>
            </div>

            <div class="z-formrow">
                <label for="mUSoundSearchTerm">{gt text='Search for'}:</label>
                <input type="text" id="mUSoundSearchTerm" name="q" class="z-floatleft" style="width: 150px; margin-right: 10px" />
                <input type="button" id="mUSoundSearchGo" name="gosearch" value="{gt text='Filter'}" style="width: 80px" />
            </div>
            <div style="margin-left: 6em">
                {pager display='page' rowcount=$pager.numitems limit=$pager.itemsperpage posvar='pos' template='pagercss.tpl' maxpages='10'}
            </div>
            <input type="submit" id="mUSoundSubmit" name="submitButton" value="{gt text='Change selection'}" />
            <input type="button" id="mUSoundCancel" name="cancelButton" value="{gt text='Cancel'}" />
            <br />
        </fieldset>
    </div>
    </form>

    <script type="text/javascript">
    /* <![CDATA[ */
        document.observe('dom:loaded', function() {
            mUSound.finder.onLoad();
        });
    /* ]]> */
    </script>

    {*
    <div class="musound-finderform">
        <fieldset>
            {modfunc modname='MUSound' type='admin' func='edit'}
        </fieldset>
    </div>
    *}
</body>
</html>
