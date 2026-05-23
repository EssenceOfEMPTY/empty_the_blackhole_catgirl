dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local entity, tag = get_root_entity( ), 'empty_adjust'

set_comp_value( entity, 'VariableStorageComponent', tag, {
	value_int = 0,
}, nil, nil )
