dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

function shot( proj )
	add_comp_remove_dupli( proj, 'HomingComponent', 'homing_form', {
		_tags = 'homing_form',
		detect_distance = 325,
		homing_targeting_coeff = 150,
		homing_velocity_multiplier = 0.96,
		max_turn_rate = math.pi / 30,
	}, nil )
end
