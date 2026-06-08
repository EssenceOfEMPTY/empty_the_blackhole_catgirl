dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_command_utility.lua' )

local niko = get_root_entity( )
local x, y = EntityGetTransform( niko )

local golds = EntityGetWithTag( 'gold_nugget' )

local dist_full, pow = 325, 40

for _, gold in ipairs( golds ) do
	if ( is_has_comp( gold, 'PhysicsBodyComponent' ) ) then
		local gx, gy = EntityGetTransform( gold )

		local dist = math.sqrt( ( x - gx ) ^ 2 + ( y - gy ) ^ 2 )

		if ( dist < dist_full ) then
			local dir = -math.atan( ( y - gy ), ( x - gx ) )

			local v_x, v_y = math.cos( dir ), -math.sin( dir )

			PhysicsApplyForce( gold, v_x * pow, v_y * pow )
		end
	end
end
