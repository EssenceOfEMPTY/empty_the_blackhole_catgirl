dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

function item_pickup( heart, who, name )
	local x, y = EntityGetTransform( heart )

	local max_hp, max_hp_cap = get_comp_value( who, 'DamageModelComponent', nil, {
		{ 'max_hp', 1 / get_scale( ) },
		{ 'max_hp_cap', 0 },
	}, nil )

	local delta = max_hp

	local add_num = 50 / get_scale( )
	local mul = get_globals_num( 'HEARTS_MORE_EXTRA_HP_MULTIPLIER', 1 )
	local also_heal = get_globals_num( 'EMPTY_HEARTS_ALSO_HEAL', 0 )

	add_num = add_num * mul

	max_hp = max_hp + add_num

	if ( max_hp_cap > 0 ) then
		max_hp = math.min( max_hp, max_hp_cap )
	end

	set_comp_value( who, 'DamageModelComponent', nil, {
		max_hp = max_hp,
		max_hp_cap = max_hp_cap,
	}, nil, nil )

	delta = delta - max_hp

	if ( also_heal > 0 and delta < 0 ) then
		EntityInflictDamage( who, delta, 'DAMAGE_HEALING', '', 'DISINTEGRATED', 0, 0, 0 )
	end

	EntityLoad( 'data/entities/particles/image_emitters/heart_fullhp_effect.xml', x, y - 12 )
	EntityLoad( 'data/entities/particles/heart_out.xml', x, y - 8 )

	local desc = GameTextGet( '$logdesc_heart', tostring( math.floor( max_hp * get_scale( ) ) ) )

	if ( delta == 0 ) then
		desc = GameTextGet( '$logdesc_heart_blocked', tostring( math.floor( max_hp * get_scale( ) ) ) )
	elseif ( delta < 0 ) then
		desc = desc .. GameTextGet( '$empty_also_heal_extra_text' )
	end

	GamePrintImportant( '$log_heart', desc )
	GameTriggerMusicCue( 'item' )

	EntityKill( heart )
end
