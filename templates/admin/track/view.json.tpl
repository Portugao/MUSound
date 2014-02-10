{* purpose of this template: tracks view json view in admin area *}
{musoundTemplateHeaders contentType='application/json'}
[
{foreach item='item' from=$items name='tracks'}
    {if not $smarty.foreach.tracks.first},{/if}
    {$item->toJson()}
{/foreach}
]
