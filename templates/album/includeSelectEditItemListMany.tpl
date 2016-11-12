{* purpose of this template: inclusion template for display of related albums *}
{icon type='edit' size='extrasmall' assign='editImageArray'}
{assign var='editImage' value="<img src=\"`$editImageArray.src`\" width=\"16\" height=\"16\" alt=\"\" />"}
{icon type='delete' size='extrasmall' assign='removeImageArray'}
{assign var='removeImage' value="<img src=\"`$removeImageArray.src`\" width=\"16\" height=\"16\" alt=\"\" />"}

<input type="hidden" id="{$idPrefix}ItemList" name="{$idPrefix}ItemList" value="{if isset($items) && (is_array($items) || is_object($items))}{foreach name='relLoop' item='item' from=$items}{$item.id}{if $smarty.foreach.relLoop.last ne true},{/if}{/foreach}{/if}" />
<input type="hidden" id="{$idPrefix}Mode" name="{$idPrefix}Mode" value="1" />

<ul id="{$idPrefix}ReferenceList">
{if isset($items) && (is_array($items) || is_object($items))}
{foreach name='relLoop' item='item' from=$items}
{assign var='idPrefixItem' value="`$idPrefix`Reference_`$item.id`"}
<li id="{$idPrefixItem}">
    {$item->getTitleFromDisplayPattern()}
    <a id="{$idPrefixItem}Edit" href="{modurl modname='MUSound' type=$lct func='edit' ot='album'  id=$item.id forcelongurl=true}">{$editImage}</a>
     <a id="{$idPrefixItem}Remove" href="javascript:musoundRemoveRelatedItem('{$idPrefix}', '{$item.id}');">{$removeImage}</a>
    <br />
    {if $item.uploadCover ne '' && isset($item.uploadCoverFullPath) && $item.uploadCoverMeta.isImage}
        {thumb image=$item.uploadCoverFullPath objectid="album-`$item.id`" preset=$relationThumbPreset tag=true img_alt=$item->getTitleFromDisplayPattern()}
    {/if}
</li>
{/foreach}
{/if}
</ul>
