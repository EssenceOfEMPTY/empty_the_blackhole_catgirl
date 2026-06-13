dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

function item_pickup( heart, who, name )
	local x, y = EntityGetTransform( heart )

	local max_hp, hp, max_hp_cap = get_comp_value( who, 'DamageModelComponent', nil, {
		{ 'max_hp', 1 / get_scale( ) },
		{ 'hp', 1 / get_scale( ) },
		{ 'max_hp_cap', 0 },
	}, nil )

	local add_num = 10 / get_scale( )
	local mul = get_globals_num( 'HEARTS_MORE_EXTRA_HP_MULTIPLIER', 1 )

	add_num = add_num * mul

	max_hp = max_hp + add_num

	if ( max_hp_cap > 0 ) then
		max_hp_cap = math.max( max_hp, max_hp_cap )
	end

	local healing = max_hp - hp

	set_comp_value( who, 'DamageModelComponent', nil, {
		max_hp = max_hp,
		hp = max_hp,
		max_hp_cap = max_hp_cap,
	}, nil, nil )

	EntityLoad( 'data/entities/particles/image_emitters/heart_fullhp_effect.xml', x, y - 12 )
	EntityLoad( 'data/entities/particles/heart_out.xml', x, y - 8 )

	GamePrintImportant( "$log_heart_fullhp_temple",
		GameTextGet( "$logdesc_heart_fullhp_temple",
			tostring( math.floor( add_num * get_scale( ) ) ),
			tostring( math.floor( max_hp * get_scale( ) ) ),
			tostring( math.floor( healing * get_scale( ) ) )
		)
	)

	EntityKill( heart )
end
