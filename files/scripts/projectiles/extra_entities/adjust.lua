dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_command_utility.lua' )

local proj, tag = get_root_entity( ), 'adjust'
local paras = parse_and_evaluate_command_paras( tag, proj, {
	'frames',
	'level',
}, '%' )

if ( paras ) then
	if ( is_not_0_num( paras.frames ) and is_not_0_num( paras.level ) ) then
		remove_speed_limit( proj )

		local sp_min, sp_max = get_comp_value( proj, 'ProjectileComponent', nil, {
			{ 'speed_min', 1000 },
			{ 'speed_max', 1000 },
		}, nil )

		local mul = ( 8 * paras.level - 4 ) * ( paras.frames / max_adjust )

		local speed_data = {
			speed_min = sp_min * mul,
			speed_max = sp_max * mul,
		}

		set_comp_value( proj, 'ProjectileComponent', nil, speed_data, nil, nil )

		mul = ( 6 + 7 * paras.level ) * ( paras.frames / max_adjust )

		damage_mul( proj, mul )
	end
end
