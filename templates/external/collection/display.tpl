{* Purpose of this template: Display one certain collection within an external context *}
<div id="collection{$collection.id}" class="musound-external-collection">
{if $displayMode eq 'link'}
    <p class="musound-external-link">
    <a href="{modurl modname='MUSound' type='user' func='display' ot='collection'  id=$collection.id}" title="{$collection->getTitleFromDisplayPattern()|replace:"\"":""}">
    {$collection->getTitleFromDisplayPattern()|notifyfilters:'musound.filter_hooks.collections.filter'}
    </a>
    </p>
{/if}
{checkpermissionblock component='MUSound::' instance='::' level='ACCESS_EDIT'}
    {* for normal users without edit permission show only the actual file per default *}
    {if $displayMode eq 'embed'}
        <p class="musound-external-title">
            <strong>{$collection->getTitleFromDisplayPattern()|notifyfilters:'musound.filter_hooks.collections.filter'}</strong>
        </p>
    {/if}
{/checkpermissionblock}

{if $displayMode eq 'link'}
{elseif $displayMode eq 'embed'}
    <div class="musound-external-snippet">
        &nbsp;
    </div>

    {* you can distinguish the context like this: *}
    {*if $source eq 'contentType'}
        ...
    {elseif $source eq 'scribite'}
        ...
    {/if*}

    {* you can enable more details about the item: *}
    {*
        <p class="musound-external-description">
            {if $collection.description ne ''}{$collection.description}<br />{/if}
        </p>
    *}
{/if}
</div>
