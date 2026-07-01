dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local death = tonumber( StatsGlobalGetValue( 'death_count' ) ) or 0

function shot( proj )
	if ( is_has_comp( proj, 'VelocityComponent' ) ) then
		remove_speed_limit( proj )

		local vel_x, vel_y = get_vel( proj )

		local speed_mul = get_log_mul( math.sqrt( vel_x ^ 2 + vel_y ^ 2 ), {
			min_num = 100,
			max_num = 1600,
			min_log = 4.0 * cap( 1, death, 4 ),
			max_log = 1.0,
			log_e = 1.33,
		} )

		set_vel( proj, vel_x * speed_mul, vel_y * speed_mul )

		set_comp_value( proj, 'VelocityComponent', nil, {
			{ 'liquid_drag', 0 },
			{ 'air_friction', 0 },
			{ 'gravity_y', 0 },
			{ 'gravity_x', 0 },
			{ 'penetrate_world_velocity_coeff', 1 },
		}, nil, nil )
	end

	if ( is_has_comp( proj, 'ProjectileComponent' ) ) then
		local shooter = get_shooter( proj, 0 )

		if ( is_not_0_num( shooter ) ) then
			local atk_mul = get_comp_value( shooter, 'VariableStorageComponent', 'empty_atk_mul', {
				{ 'value_float', 1 },
			}, nil )

			if ( atk_mul ~= 1 ) then
				local is_has_dmg, dmg_data = damage_mul( proj, atk_mul )

				if ( dmg_data.explosion and dmg_data.explosion > 0 ) then
					set_comp_value( proj, 'ProjectileComponent', nil, {
						{ 'explosion_dont_damage_shooter', true },
					}, nil, nil )

					local explo_range, ray_energy = get_comp_obj_value( proj, 'ProjectileComponent', nil, {
						{ 'config_explosion', 'explosion_radius', 0 },
						{ 'config_explosion', 'ray_energy', 0 },
					}, nil )

					if ( explo_range > 0 ) then
						local explo_mul = math.log( 10 + atk_mul, 10 )

						set_comp_obj_value( proj, 'ProjectileComponent', nil, {
							{ 'config_explosion', 'explosion_radius', explo_range * explo_mul },
							{ 'config_explosion', 'ray_energy', ray_energy * explo_mul },
						}, nil, nil )
					end
				end
			end
		end
	end
end
