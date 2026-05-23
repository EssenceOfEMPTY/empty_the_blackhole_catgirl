dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_command_utility.lua' )

local proj, tag = get_root_entity( ), 'empty_adjust'

local shooter, spread = get_comp_info( proj, 'ProjectileComponent', nil, {
	{ 'mWhoShot', 0 },
	{ 'direction_random_rad', 0 },
}, nil )

if ( shooter > 0 ) then
	local count = get_comp_info( shooter, 'VariableStorageComponent', tag, {
		{ 'value_int', 0 },
	}, nil )

	if ( count > 0 ) then
		local mul = 1 + count / 90

		local attri = {
			direction_random_rad = spread + 60 - count
		}

		local p_dmg = get_comp_info( proj, 'ProjectileComponent', nil, {
			{ 'damage', 0 },
		} )

		if ( p_dmg > 0 ) then
			attri[ 'damage' ] = p * mul
		end

		set_comp_value( proj, 'ProjectileComponent', nil, attri, nil, nil )

		local ex_dmg = get_comp_obj_info( proj, 'ProjectileComponent', nil, {
			{ 'config_explosion', 'damage', 0 },
		}, nil )

		if ( ex_dmg > 0 ) then
			set_comp_obj_value( proj, 'ProjectileComponent', nil, {
				{ 'config_explosion', 'damage', ex_dmg * mul }
			}, nil, nil )
		end

		local dmg = { }

		for i, _ in ipairs( all_proj_dmg ) do
			local tmp = get_comp_obj_info( proj, 'ProjectileComponent', nil, {
				{ 'damage_by_type', _, 0 },
			}, nil )

			if ( tmp > 0 ) then
				table.insert( dmg, {
					'damage_by_type', _, tmp * mul
				} )
			end
		end

		set_comp_obj_value( proj, 'ProjectileComponent', nil, dmg, nil, nil )

		add_comp( shooter, 'LuaComponent', {
			_tag = tag,
			script_source_file = empty_path .. 'scripts/perks/adjust_remove_frame.lua',
			execute_every_n_frame = 1,
			remove_after_executed = true,
		}, nil )
	end
end
