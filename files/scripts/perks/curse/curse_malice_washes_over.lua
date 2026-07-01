dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local tag = 'CURSE_MALICE_WASHES_OVER'

local cloud = get_up_entity_table( ).update get_up_entity( )
local tar = get_comp_value( cloud, 'VariableStorageComponent', tag, {
	{ 'value_int', 0 },
}, nil )

if ( not is_not_0_num( tar ) ) then
	return
elseif ( not is_alive( tar ) ) then
	EntityKill( cloud )
elseif ( not is_has_comp( tar, 'VariableStorageComponent', tag .. '_ACTIVE' ) ) then
	EntityKill( cloud )
else
	local x, y = EntityGetTransform( cloud )
	local px, py = EntityGetTransform( tar )

	local dis = sqrt_p2_add( x - px, y - py )

	if ( dis > 1 ) then
		x, y = move_toward( x, y, px, py, get_log_mul( dis, {
			min_num = 1,
			max_num = 512,
			min_log = 0.32,
			max_log = 5,
			log_e = 0.64,
		} ) )

		tp( cloud, x, y )
	end
end
