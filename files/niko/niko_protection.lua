dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

function damage_about_to_be_received( dmg, x, y, res, cri_chance )
	local shooter = get_root_entity( )

	if ( is_not_0_num( shooter ) ) then
		local def_mul = get_comp_value( shooter, 'VariableStorageComponent', 'empty_def_mul', {
			{ 'value_float', 1 }
		}, nil )

		if ( dmg ~= 0 and def_mul ~= 1 ) then
			if ( dmg > 0 ) then
				return dmg * def_mul, 0
			else
				return dmg / def_mul, 0
			end
		end
	end

	return dmg, cri_chance
end
