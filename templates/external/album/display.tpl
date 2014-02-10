{* Purpose of this template: Display one certain album within an external context *}
<div id="album{$album.id}" class="musound-external-album">
{if $displayMode eq 'link'}
    <p class="musound-external-link">
    <a href="{modurl modname='MUSound' type='user' func='display' ot='album' id=$album.id}" title="{$album->getTitleFromDisplayPattern()|replace:"\"":""}">
    {$album->getTitleFromDisplayPattern()|notifyfilters:'musound.filter_hooks.albums.filter'}
    </a>
    </p>
{/if}
{checkpermissionblock component='MUSound::' instance='::' level='ACCESS_EDIT'}
    {if $displayMode eq 'embed'}
        <p class="musound-external-title">
            <strong>{$album->getTitleFromDisplayPattern()|notifyfilters:'musound.filter_hooks.albums.filter'}</strong>
        </p>
    {/if}
{/checkpermissionblock}

{if $displayMode eq 'link'}
{elseif $displayMode eq 'embed'}
    <div class="musound-external-snippet">
        {if $album.uploadCover ne ''}
          <a href="{$album.uploadCoverFullPathURL}" title="{$album->getTitleFromDisplayPattern()|replace:"\"":""}"{if $album.uploadCoverMeta.isImage} rel="imageviewer[album]"{/if}>
          {if $album.uploadCoverMeta.isImage}
              {thumb image=$album.uploadCoverFullPath objectid="album-`$album.id`" preset=$albumThumbPresetUploadCover tag=true img_alt=$album->getTitleFromDisplayPattern()}
          {else}
              {gt text='Download'} ({$album.uploadCoverMeta.size|musoundGetFileSize:$album.uploadCoverFullPath:false:false})
          {/if}
          </a>
        {else}&nbsp;{/if}
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
            {if $album.description ne ''}{$album.description}<br />{/if}
            {assignedcategorieslist categories=$album.categories doctrine2=true}
        </p>
    *}
{/if}
</div>
