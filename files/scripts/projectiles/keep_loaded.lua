dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local entity = get_root_entity( )

local x, y = EntityGetTransform( entity )

shoot_proj( entity, empty_path .. 'entities/projectiles/keep_loaded_token.xml', x, y, 128, 128, nil, nil, nil )
shoot_proj( entity, empty_path .. 'entities/projectiles/keep_loaded_token.xml', x, y, 128, -128, nil, nil, nil )
shoot_proj( entity, empty_path .. 'entities/projectiles/keep_loaded_token.xml', x, y, 0, 0, nil, nil, nil )
shoot_proj( entity, empty_path .. 'entities/projectiles/keep_loaded_token.xml', x, y, -128, 128, nil, nil, nil )
shoot_proj( entity, empty_path .. 'entities/projectiles/keep_loaded_token.xml', x, y, -128, -128, nil, nil, nil )
