dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local proj = get_root_entity( )
local shooter = get_shooter( proj, 0 )

if ( is_not_0_num( shooter ) and is_alive( shooter ) ) then
	local x, y = EntityGetTransform( shooter )

	tp( proj, x, y )
end
