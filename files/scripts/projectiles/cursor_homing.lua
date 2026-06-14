dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local proj = get_root_entity( )
local shooter = get_shooter( proj, 0 )

if ( is_not_0_num( shooter ) ) then
	local cur_x, cur_y = get_cur_xy( shooter )

	if ( cur_x and cur_y ) then
		local projs = get_all_projs( )

		for i, _ in ipairs( projs ) do
			local x, y = EntityGetTransform( _ )

			local angle, length = math.pi - atan( cur_y - y, cur_x - x ), 500

			local vel_x, vel_y = -math.cos( angle ), math.sin( angle )

			set_vel( p, vel_x * length, vel_y * length )
		end
	end
end
