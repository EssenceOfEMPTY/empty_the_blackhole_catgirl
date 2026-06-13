dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local proj = get_root_entity( )
local shooter = get_shooter( proj, 0 )

if ( is_not_0_num( shooter ) and is_alive( shooter ) ) then
	local cur = get_comp_value( shooter, 'ControlsComponent', nil, {
		{ 'mMousePosition', {
			v_1 = 'nil',
			v_2 = 'nil',
		} },
	}, nil )

	if ( is_not_nan_num( cur.v_1 ) and is_not_nan_num( cur.v_2 ) ) then
		tp( shooter, cur.v_1, cur.v_2 )

		local max_hp = get_comp_value( shooter, 'DamageModelComponent', nil, {
			{ 'max_hp', 0 },
		}, nil )

		if ( max_hp > 0 ) then
			EntityInflictDamage( shooter, max_hp * 0.33, 'DAMAGE_CURSE', '$empty_death_msg_cursor_teleport', 'NONE', 0, 0, shooter )
		end
	end
end
