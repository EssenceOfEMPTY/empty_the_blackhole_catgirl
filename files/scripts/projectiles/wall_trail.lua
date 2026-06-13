dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local proj = get_root_entity( )
local proj_x, proj_y = EntityGetTransform( proj )

local ng_num = get_ng_count( )

shoot_proj( proj, empty_path .. 'entities/projectiles/wall_piece.xml', proj_x, proj_y, 0, 0, nil, nil, function ( from, e, x, y, vel_x, vel_y, tag )
	if ( ng_num > 0 ) then
		local lifetime = get_comp_value( e, 'ProjectileComponent', nil, {
			{ 'lifetime', 0 },
		}, nil )

		if ( lifetime > 0 ) then
			set_comp_value( e, 'ProjectileComponent', nil, {
				lifetime = ( 1 + 0.2 * ng_num ) * lifetime,
			}, nil, nil )
		end

		local dmg = get_comp_obj_value( e, 'ProjectileComponent', nil, {
			{ 'damage_by_type', 'slice', 0 },
		}, nil )

		if ( dmg > 0 ) then
			set_comp_obj_value( e, 'ProjectileComponent', nil, {
				{ 'damage_by_type', 'slice', ( 4 ^ ( 1 + ng_num ) ) * dmg }
			}, nil, nil )
		end
	end
end )
