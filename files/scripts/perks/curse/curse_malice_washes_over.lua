dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local entity = get_up_entity_table( )
local cloud, tar = entity.update, entity.root

if ( is_not_0_num( tar ) and is_alive( tar ) ) then
	local x, y = EntityGetTransform( tar )
	local cx, cy = EntityGetTransform( cloud )

	x, y = move_toward( cx, cy, x, y, 0.72 )

	tp( cloud, x, y )
end
