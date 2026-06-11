dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local entity = get_up_entity_table( )
local cloud, tar = entity.update, entity.root

if ( is_not_0_num( tar ) and is_alive( tar ) ) then
	local x1, y1 = EntityGetTransform( cloud )
	local x2, y2 = EntityGetTransform( tar )

	local x, y = move_toward( x1, y1, x2, y2, 0.72 )

	tp( cloud, x, y )
end
