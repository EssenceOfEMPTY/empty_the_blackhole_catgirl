dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local proj = get_root_entity( )

remove_all_comp( proj, 'AudioComponent', nil )
remove_all_comp( proj, 'AudioLoopComponent', nil )
