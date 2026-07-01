dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local shooter, tag = get_root_entity( ), 'adjust'

set_comp_value( shooter, 'VariableStorageComponent', tag, {
	{ 'value_int', 0 },
}, nil, nil )
