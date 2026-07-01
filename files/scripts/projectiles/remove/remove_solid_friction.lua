dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local proj = get_root_entity( )

set_comp_value( proj, 'ProjectileComponent', nil, {
	{ 'penetrate_world', true },
	{ 'penetrate_world_velocity_coeff', 1 },
}, nil, nil )
