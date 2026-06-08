dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local entity, tag = get_root_entity( ), 'hearty_max_hp'

if ( is_alive( entity ) and not EntityHasTag( entity, 'empty_hearty_immunity' ) ) then
	local max_hp = get_comp_info( entity, 'VariableStorageComponent', tag, {
		{ 'value_float', nil },
	}, nil )

	if ( is_not_0_num( max_hp ) and max_hp > 0 ) then
		set_comp_value( entity, 'DamageModelComponent', nil, {
			max_hp = max_hp,
		}, nil, nil )
	end
end
