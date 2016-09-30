{* Purpose of this template: Display item information for previewing from other modules *}
<dl id="album{$album.id}">
<dt>{$album->getTitleFromDisplayPattern()|notifyfilters:'musound.filter_hooks.albums.filter'}</dt>
<dd>{if $album.uploadCover ne ''}
<a href="{$album.uploadCoverFullPathURL}" title="{$album->getTitleFromDisplayPattern()|replace:"\"":""}"{if $album.uploadCoverMeta.isImage} rel="imageviewer[album]"{/if}>
{if $album.uploadCoverMeta.isImage}
    {thumb image=$album.uploadCoverFullPath objectid="album-`$album.id`" preset=$albumThumbPresetUploadCover tag=true img_alt=$album->getTitleFromDisplayPattern()}
{else}
    {gt text='Download'} ({$album.uploadCoverMeta.size|musoundGetFileSize:$album.uploadCoverFullPath:false:false})
{/if}
</a>
{else}&nbsp;{/if}
</dd>
{if $album.description ne ''}<dd>{$album.description}</dd>{/if}
<dd>{assignedcategorieslist categories=$album.categories doctrine2=true}</dd>
</dl>
