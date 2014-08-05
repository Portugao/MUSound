{* purpose of this template: albums view json view *}
{musoundTemplateHeaders contentType='application/json'}
[
{foreach item='item' from=$items name='albums'}
    {if not $smarty.foreach.albums.first},{/if}
    {$item->toJson()}
{/foreach}
]
