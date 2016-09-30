{* Purpose of this template: Display search options *}
<input type="hidden" id="mUSoundActive" name="active[MUSound]" value="1" />
<div>
    <input type="checkbox" id="active_mUSoundAlbums" name="mUSoundSearchTypes[]" value="album"{if $active_album} checked="checked"{/if} />
    <label for="active_mUSoundAlbums">{gt text='Albums' domain='module_musound'}</label>
</div>
<div>
    <input type="checkbox" id="active_mUSoundTracks" name="mUSoundSearchTypes[]" value="track"{if $active_track} checked="checked"{/if} />
    <label for="active_mUSoundTracks">{gt text='Tracks' domain='module_musound'}</label>
</div>
<div>
    <input type="checkbox" id="active_mUSoundCollections" name="mUSoundSearchTypes[]" value="collection"{if $active_collection} checked="checked"{/if} />
    <label for="active_mUSoundCollections">{gt text='Collections' domain='module_musound'}</label>
</div>
