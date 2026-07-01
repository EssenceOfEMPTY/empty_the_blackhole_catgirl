dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_command_utility.lua' )

new_modifiers = {
	adjust = function( )
		local tag = 'adjust'
		local tagging = tag .. 'ing'

		local shooter = get_root_entity( )
		local frames, level = get_comp_value( shooter, 'VariableStorageComponent', tag, {
			{ 'value_int', 0 },
			{ 'value_float', 1 },
		}, nil )

		if ( frames >= max_adjust ) then
			c.extra_entities = c.extra_entities
				.. empty_path .. 'entities/misc/remove/remove_liquid_friction.xml,'
				.. empty_path .. 'entities/misc/remove/remove_air_friction.xml,'
				.. empty_path .. 'entities/misc/remove/remove_gravity.xml,'
		end

		c.spread_degrees = c.spread_degrees + ( 1 + level ) * ( 30 - frames / 2 )

		add_desc_by_info( c, {
			replace = true,
			update = true,
			merge = false,
		}, {
			id = tag,
			shooter = shooter,
			frames = frames,
			level = level,
		}, c.extra_entities .. empty_path .. 'entities/misc/extra_entities/adjust.xml,', '%' )

		add_comp_or_not( shooter, 'LuaComponent', tagging, {
			{ '_tags', tagging },
			{ 'script_source_file', empty_path .. 'scripts/perks/adjust_remove_frame.lua' },
			{ 'execute_every_n_frame', 0 },
			{ 'remove_after_executed', true },
		}, nil )
	end,
	remove_recoil = function ( )
		shot_effects.recoil_knockback = 0
	end,
}

for i, _ in pairs( new_modifiers ) do
	extra_modifiers[ i ] = _
end
