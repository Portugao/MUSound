{* Purpose of this template: Display a popup selector of albums for scribite integration *}
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="{lang}" lang="{lang}">
<head>
    <title>{gt text='Search and select album'}</title>
    <link type="text/css" rel="stylesheet" href="{$baseurl}style/core.css" />
    <link type="text/css" rel="stylesheet" href="{$baseurl}modules/MUSound/style/style.css" />
    <link type="text/css" rel="stylesheet" href="{$baseurl}modules/MUSound/style/finder.css" />
    {assign var='ourEntry' value=$modvars.ZConfig.entrypoint}
    <script type="text/javascript">/* <![CDATA[ */
        if (typeof(Zikula) == 'undefined') {var Zikula = {};}
        Zikula.Config = {'entrypoint': '{{$ourEntry|default:'index.php'}}', 'baseURL': '{{$baseurl}}'}; /* ]]> */</script>
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
    <a href="{modurl modname='MUSound' type='external' func='finder' objectType='track' editor=$editorName}" title="{gt text='Search and select track'}">{gt text='Tracks'}</a> | 
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
            <legend>{gt text='Search and select album'}</legend>
            
            {if $properties ne null && is_array($properties)}
                {gt text='All' assign='lblDefault'}
                {nocache}
                {foreach key='propertyName' item='propertyId' from=$properties}
                    <div class="z-formrow categoryselector">
                        {modapifunc modname='MUSound' type='category' func='hasMultipleSelection' ot=$objectType registry=$propertyName assign='hasMultiSelection'}
                        {gt text='Category' assign='categoryLabel'}
                        {assign var='categorySelectorId' value='catid'}
                        {assign var='categorySelectorName' value='catid'}
                        {assign var='categorySelectorSize' value='1'}
                        {if $hasMultiSelection eq true}
                            {gt text='Categories' assign='categoryLabel'}
                            {assign var='categorySelectorName' value='catids'}
                            {assign var='categorySelectorId' value='catids__'}
                            {assign var='categorySelectorSize' value='8'}
                        {/if}
                        <label for="{$categorySelectorId}{$propertyName}">{$categoryLabel}</label>
                        &nbsp;
                            {selector_category name="`$categorySelectorName``$propertyName`" field='id' selectedValue=$catIds.$propertyName categoryRegistryModule='MUSound' categoryRegistryTable=$objectType categoryRegistryProperty=$propertyName defaultText=$lblDefault editLink=false multipleSize=$categorySelectorSize}
                            <span class="z-sub z-formnote">{gt text='This is an optional filter.'}</span>
                    </div>
                {/foreach}
                {/nocache}
            {/if}

            <div class="z-formrow">
                <label for="mUSoundPasteAs">{gt text='Paste as'}:</label>
                    <select id="mUSoundPasteAs" name="pasteas">
                        <option value="1">{gt text='Link to the album'}</option>
                        <option value="2">{gt text='ID of album'}</option>
                        <option value="3">{gt text='Player'}</option>
                    </select>
            </div>
            <br />

            <div class="z-formrow">
                <label for="mUSoundObjectId">{gt text='Album'}:</label>
                    <div id="musoundItemContainer">
                        <ul>
                        {foreach item='album' from=$items}
                            <li>
                                <a href="#" onclick="musound.finder.selectItem({$album.id})" onkeypress="musound.finder.selectItem({$album.id})">{$album->getTitleFromDisplayPattern()}</a>
                                <input type="hidden" id="url{$album.id}" value="{modurl modname='MUSound' type='user' func='display' ot='album'  id=$album.id fqurl=true}" />
                                <input type="hidden" id="title{$album.id}" value="{$album->getTitleFromDisplayPattern()|replace:"\"":""}" />
                                <input type="hidden" id="desc{$album.id}" value="{capture assign='description'}{if $album.description ne ''}{$album.description}{/if}
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
                    <select id="mUSoundSort" name="sort" style="width: 150px" class="z-floatleft" style="margin-right: 10px">
                    <option value="id"{if $sort eq 'id'} selected="selected"{/if}>{gt text='Id'}</option>
                    <option value="workflowState"{if $sort eq 'workflowState'} selected="selected"{/if}>{gt text='Workflow state'}</option>
                    <option value="title"{if $sort eq 'title'} selected="selected"{/if}>{gt text='Title'}</option>
                    <option value="description"{if $sort eq 'description'} selected="selected"{/if}>{gt text='Description'}</option>
                    <option value="author"{if $sort eq 'author'} selected="selected"{/if}>{gt text='Author'}</option>
                    <option value="uploadCover"{if $sort eq 'uploadCover'} selected="selected"{/if}>{gt text='Upload cover'}</option>
                    <option value="publishedDate"{if $sort eq 'publishedDate'} selected="selected"{/if}>{gt text='Published date'}</option>
                    <option value="publishedText"{if $sort eq 'publishedText'} selected="selected"{/if}>{gt text='Published text'}</option>
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
                    <input type="text" id="mUSoundSearchTerm" name="searchterm" style="width: 150px" class="z-floatleft" style="margin-right: 10px" />
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
            musound.finder.onLoad();
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
