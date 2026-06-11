dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local proj = get_root_entity( )
local shooter = get_shooter( proj, 0 )

if ( is_not_0_num( shooter ) and is_alive( shooter ) ) then
	local cur = get_comp_info( shooter, 'ControlsComponent', nil, {
		{ 'mMousePosition', {
			v_1 = 'nil',
			v_2 = 'nil',
		} },
	}, nil )

	if ( is_not_nan_num( cur.v_1 ) and is_not_nan_num( cur.v_2 ) ) then
		tp( proj, cur.v_1, cur.v_2 )
	end
end
