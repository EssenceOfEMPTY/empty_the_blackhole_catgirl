dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local entity, tag = get_root_entity( ), 'hearty_max_hp'

if ( is_alive( entity ) and not EntityHasTag( entity, 'empty_hearty_immunity' ) ) then
	local max_hp, hp = get_comp_value( entity, 'DamageModelComponent', nil, {
		{ 'max_hp', 1 / get_scale( ) },
		{ 'hp', 1 / get_scale( ) },
	}, nil )

	if ( max_hp >= 2 / get_scale( ) and not ( EntityHasTag( entity, 'boss_centipede' ) and ( GameGetOrbCountThisRun( ) > 32 ) ) ) then
		if ( not is_has_comp( entity, 'VariableStorageComponent', tag ) ) then
			add_comp_remove_dupli( entity, 'VariableStorageComponent', tag, {
				_tags = tag,
				value_float = max_hp,
			}, nil )
		end

		max_hp = max_hp / 2.0

		if ( hp > max_hp ) then
			set_comp_value( entity, 'DamageModelComponent', nil, {
				hp = max_hp,
				max_hp = max_hp,
			}, nil, nil )
		else
			set_comp_value( entity, 'DamageModelComponent', nil, {
				max_hp = max_hp,
			}, nil, nil )
		end
	end
end
