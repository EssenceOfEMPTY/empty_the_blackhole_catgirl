dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local death = tonumber( StatsGlobalGetValue( 'death_count' ) ) or 0

function shot( proj )
	if ( is_has_comp( proj, 'VelocityComponent' ) ) then
		remove_speed_limit( proj )

		local vel_xy = get_comp_info( proj, 'VelocityComponent', nil, {
			{
				'mVelocity',
				{
					v_1 = 0,
					v_2 = 0,
				},
			},
		}, nil )

		local mul = get_log_mul( math.sqrt( vel_xy.v_1 ^ 2 + vel_xy.v_2 ^ 2 ), {
			min_num = 100,
			max_num = 1600,
			min_log = 4.0 * cap( 1, death, 4 ),
			max_log = 1.0,
		} )

		set_comp_value( proj, 'VelocityComponent', nil, {
			liquid_drag = 0,
			air_friction = 0,
			gravity_y = 0,
			gravity_x = 0,
			mVelocity = { vel_xy.v_1 * mul, vel_xy.v_2 * mul },
		}, nil, nil )
	end

	if ( is_has_comp( proj, 'ProjectileComponent' ) ) then
		local is_has_dmg = damage_mul( proj, 200 * cap( 1, death, 10 ) )

		local need_homing = is_need_homing( proj )

		if ( is_has_dmg and need_homing ) then
			add_comp_remove_dupli( proj, 'HomingComponent', 'niko_homing', {
				_tags = 'niko,niko_homing',
				detect_distance = 325,
				homing_targeting_coeff = 150,
				homing_velocity_multiplier = 0.96,
				max_turn_rate = math.pi / 30,
			}, nil )

			set_comp_value( proj, 'ProjectileComponent', nil, {
				penetrate_world = false,
				penetrate_world_velocity_coeff = 1,
			}, nil, nil )
		end
	end
end
