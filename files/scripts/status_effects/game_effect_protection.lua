dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local entity = get_up_entity_table( )
local eff = get_comp_info( entity.update, 'VariableStorageComponent', 'effect_name', {
	{ 'value_string', nil },
}, nil )

if ( is_not_nil_str( eff ) and EntityHasTag( entity.root, 'empty_' .. eff .. '_immunity' ) ) then
	remove_child( entity.update )
end
