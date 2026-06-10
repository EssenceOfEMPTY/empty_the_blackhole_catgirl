dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

function shot( proj )
	if ( is_has_comp( proj, 'VelocityComponent' ) ) then
		---<<<<<<<<<<<< 移除速度限制 >>>>>>>>>>>>---

		remove_speed_limit( proj )

		---<<<<<<<<<<<< 移除非地面阻力、倍速投射物 >>>>>>>>>>>>---

		local vel = get_comp_info( proj, 'VelocityComponent', nil, {
			{
				'mVelocity',
				{
					v_1 = 0,
					v_2 = 0,
				},
			},
		}, nil )

		local mul = get_log_mul( math.sqrt( vel.v_1 ^ 2 + vel.v_2 ^ 2 ), {
			min_num = 100,
			max_num = 3600,
			min_log = 16.0,
			max_log = 1.00,
		} )

		set_comp_value( proj, 'VelocityComponent', nil, {
			liquid_drag = 0,
			air_friction = 0,
			gravity_y = 0,
			gravity_x = 0,
			mVelocity = { vel.v_1 * mul, vel.v_2 * mul },
		}, nil, nil )
	end

	if ( is_has_comp( proj, 'ProjectileComponent' ) ) then
		---<<<<<<<<<<<< 全伤害倍率 >>>>>>>>>>>>---

		damage_mul( proj, 2000 )
	end
end
