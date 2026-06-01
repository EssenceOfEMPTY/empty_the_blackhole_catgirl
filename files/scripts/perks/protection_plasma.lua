dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

function damage_about_to_be_received( dmg, x, y, res, cri_chance )
	if ( is_has_comp( res, 'LaserEmitterComponent', nil, nil ) ) then
		return 0, cri_chance
	end

	local v_comps = get_all_comp( res, 'VariableStorageComponent', nil, nil )

	for i, v_comp in ipairs( v_comps ) do
		local members = ComponentGetMembers( v_comp )

		if ( members and members.value_string == 'orbit_lasers_laser' ) then
			return 0, cri_chance
		end
	end

	return dmg, cri_chance
end
