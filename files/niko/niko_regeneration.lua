dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_command_utility.lua' )

local death = tonumber( StatsGlobalGetValue( 'death_count' ) ) or 0

local niko = get_root_entity( )

local cur_hp, max_hp = get_comp_value( niko, 'DamageModelComponent', nil, {
	{ 'hp', 1 / get_scale( ) },
	{ 'max_hp', 1 / get_scale( ) },
}, nil )

if ( cur_hp < max_hp ) then
	local reg_mul = get_comp_value( niko, 'VariableStorageComponent', 'empty_reg_mul', {
		{ 'value_float', 0 }
	}, nil )

	if ( reg_mul > 0 ) then
		local heal = -math.min( max_hp - cur_hp, reg_mul * cap( 1, death, 5 ) * max_hp )

		if ( heal < 0 ) then
			EntityInflictDamage( niko, heal, 'DAMAGE_HEALING', '', 'NONE', 0, 0, niko )

			EntityLoad( 'data/entities/particles/heal.xml', x, y )
		end
	end
end
