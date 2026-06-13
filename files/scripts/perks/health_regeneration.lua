dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_command_utility.lua' )

local entity = get_root_entity( )

local cur_hp, max_hp = get_comp_value( entity, 'DamageModelComponent', nil, {
	{ 'hp', 1 / get_scale( ) },
	{ 'max_hp', 1 / get_scale( ) },
}, nil )

if ( cur_hp < max_hp ) then
	local heal = -math.min( max_hp - cur_hp, 0.04 * max_hp )

	if ( heal < 0 ) then
		EntityInflictDamage( entity, heal, 'DAMAGE_HEALING', '', 'NONE', 0, 0, entity )

		EntityLoad( 'data/entities/particles/heal.xml', x, y )
	end
end
