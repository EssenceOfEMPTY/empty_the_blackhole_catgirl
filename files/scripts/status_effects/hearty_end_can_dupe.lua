dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local entity = get_root_entity( )

if ( is_alive( entity ) ) then
	local max_hp = get_comp_info( entity, 'DamageModelComponent', nil, {
		{ 'max_hp', 0 },
	}, nil )

	if ( max_hp > 0 ) then
		set_comp_value( entity, 'DamageModelComponent', nil, {
			max_hp = max_hp * 2,
		}, nil, nil )
	end
end
