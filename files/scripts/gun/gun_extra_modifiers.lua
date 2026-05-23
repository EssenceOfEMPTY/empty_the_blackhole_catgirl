dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_command_utility.lua' )

new_modifiers = {
	empty_adjust = function( )
		c.extra_entities = c.extra_entities .. empty_path .. 'entities/misc/extra_entities/adjust.xml,'
	end,
}

add_table( extra_modifiers, new_modifiers )
