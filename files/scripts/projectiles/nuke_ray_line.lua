dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local proj = get_root_entity( )

if ( is_has_comp( proj, 'VelocityComponent' ) ) then
	local x, y = EntityGetTransform( proj )
	local vel_x, vel_y = get_vel( proj )

	local angle, length = -math.atan( vel_y, vel_x ), 1600

	local angle_fix = angle + math.pi * 0.5
	vel_x, vel_y = math.cos( angle_fix ) * length, -math.sin( angle_fix ) * length

	shoot_proj( proj, 'data/entities/projectiles/deck/nuke.xml', x, y, vel_x, vel_y, nil, nil, nil )

	angle_fix = angle - math.pi * 0.5
	vel_x, vel_y = math.cos( angle_fix ) * length, -math.sin( angle_fix ) * length

	shoot_proj( proj, 'data/entities/projectiles/deck/nuke.xml', x, y, vel_x, vel_y, nil, nil, nil )
end
