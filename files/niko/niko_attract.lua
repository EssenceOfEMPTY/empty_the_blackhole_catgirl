dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_command_utility.lua' )

local death = tonumber( StatsGlobalGetValue( 'death_count' ) ) or 0

local golds = EntityGetWithTag( 'gold_nugget' )

if ( #golds == 0 ) then
	return
end

local niko = get_root_entity( )
local x, y = EntityGetTransform( niko )

local dist_full, pow = 200 + 25 * cap( 0, death, 8 ), 36 + 6 * cap( 0, death, 6 )

for _, gold in ipairs( golds ) do
	if ( is_has_comp( gold, 'PhysicsBodyComponent' ) ) then
		local gx, gy = EntityGetTransform( gold )

		local v_x, v_y = force_by_loc( x, y, gx, gy, dist_full, pow )

		PhysicsApplyForce( gold, v_x, v_y )
	end
end
