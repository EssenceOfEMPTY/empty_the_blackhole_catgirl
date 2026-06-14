dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local death = tonumber( StatsGlobalGetValue( 'death_count' ) ) or 0

function shot( proj )
	if ( is_has_comp( proj, 'VelocityComponent' ) ) then
		remove_speed_limit( proj )

		local vel_x, vel_y = get_vel( proj )

		local speed_mul = get_log_mul( math.sqrt( vel_x ^ 2 + vel_y ^ 2 ), {
			min_num = 100,
			max_num = 1600,
			min_log = 8.0 * cap( 1, death, 4 ),
			max_log = 1.0,
			log_e = 0.75,
		} )

		set_vel( proj, vel_x * speed_mul, vel_y * speed_mul )

		set_comp_value( proj, 'VelocityComponent', nil, {
			liquid_drag = 0,
			air_friction = 0,
			gravity_y = 0,
			gravity_x = 0,
		}, nil, nil )
	end

	if ( is_has_comp( proj, 'ProjectileComponent' ) ) then
		local shooter = get_shooter( proj, 0 )

		if ( is_not_0_num( shooter ) ) then
			local atk_mul = get_comp_value( shooter, 'VariableStorageComponent', 'empty_atk_mul', {
				{ 'value_float', 1 }
			}, nil )

			if ( atk_mul ~= 1 ) then
				damage_mul( proj, atk_mul * cap( 1, death * 1.25, 10 ) )
			end
		end
	end
end
