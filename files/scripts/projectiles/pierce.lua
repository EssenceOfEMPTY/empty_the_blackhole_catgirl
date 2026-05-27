dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local entity = get_root_entity( )

set_comp_value( entity, 'ProjectileComponent', nil, {
	on_collision_die = false,
}, nil, nil )
