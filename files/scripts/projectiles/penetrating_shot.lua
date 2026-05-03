
function shot( projectile )
	set_comp_value( projectile, 'ProjectileComponent', nil, {
		penetrate_world = true,
		penetrate_world_velocity_coeff = 1,
	}, nil )
end
