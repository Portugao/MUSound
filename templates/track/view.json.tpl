{* purpose of this template: tracks view json view *}
{musoundTemplateHeaders contentType='application/json'}[
{foreach item='track' from=$items name='tracks'}
    {if not $smarty.foreach.tracks.first},{/if}
    {$track->toJson()}
{/foreach}
]
