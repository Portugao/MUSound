{* Purpose of this template: Display a popup selector for Forms and Content integration *}
{assign var='baseID' value='track'}
<div id="{$baseID}Preview" style="float: right; width: 300px; border: 1px dotted #a3a3a3; padding: .2em .5em; margin-right: 1em">
    <p><strong>{gt text='Track information'}</strong></p>
    {img id='ajax_indicator' modname='core' set='ajax' src='indicator_circle.gif' alt='' class='z-hide'}
    <div id="{$baseID}PreviewContainer">&nbsp;</div>
</div>
<br />
<br />
{assign var='leftSide' value=' style="float: left; width: 10em"'}
{assign var='rightSide' value=' style="float: left"'}
{assign var='break' value=' style="clear: left"'}
<p>
    <label for="{$baseID}Id"{$leftSide}>{gt text='Track'}:</label>
    <select id="{$baseID}Id" name="id"{$rightSide}>
        {foreach item='track' from=$items}
            <option value="{$track.id}"{if $selectedId eq $track.id} selected="selected"{/if}>{$track->getTitleFromDisplayPattern()}</option>
        {foreachelse}
            <option value="0">{gt text='No entries found.'}</option>
        {/foreach}
    </select>
    <br{$break} />
</p>
<p>
    <label for="{$baseID}Sort"{$leftSide}>{gt text='Sort by'}:</label>
    <select id="{$baseID}Sort" name="sort"{$rightSide}>
        <option value="id"{if $sort eq 'id'} selected="selected"{/if}>{gt text='Id'}</option>
        <option value="workflowState"{if $sort eq 'workflowState'} selected="selected"{/if}>{gt text='Workflow state'}</option>
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
    <select id="{$baseID}SortDir" name="sortdir">
        <option value="asc"{if $sortdir eq 'asc'} selected="selected"{/if}>{gt text='ascending'}</option>
        <option value="desc"{if $sortdir eq 'desc'} selected="selected"{/if}>{gt text='descending'}</option>
    </select>
    <br{$break} />
</p>
<p>
    <label for="{$baseID}SearchTerm"{$leftSide}>{gt text='Search for'}:</label>
    <input type="text" id="{$baseID}SearchTerm" name="q"{$rightSide} />
    <input type="button" id="mUSoundSearchGo" name="gosearch" value="{gt text='Filter'}" />
    <br{$break} />
</p>
<br />
<br />

<script type="text/javascript">
/* <![CDATA[ */
    document.observe('dom:loaded', function() {
        mUSound.itemSelector.onLoad('{{$baseID}}', {{$selectedId|default:0}});
    });
/* ]]> */
</script>
