dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local entity = get_all_players( )

add_table( entity, get_all_entity( all_tag.enemy, nil ) )

midas_entity( entity )
