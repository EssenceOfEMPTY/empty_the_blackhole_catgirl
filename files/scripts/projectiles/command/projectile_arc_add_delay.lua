dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_command_utility.lua' )

local proj = get_root_entity( )
local command = 'projectile_arc_add'
local command_delay = command .. '_delay'

if ( proj ~= NULL_ENTITY ) then
	local v_comp = EntityGetFirstComponent( proj, 'VariableStorageComponent', command_delay )

	if ( v_comp ) then
		local paras = {
			frame = ComponentGetValue2( v_comp, 'value_int' ) or 0,
			angle = tonumber( ComponentGetValue2( v_comp, 'value_string' ) ) or 0,
			inc = ComponentGetValue2( v_comp, 'value_float' ) or 0,
		}

		paras.frame = paras.frame + 1

		local vel_x, vel_y = get_vel( proj )

		vel_x, vel_y = rot_vel( vel_x, vel_y, paras.angle + paras.frame * paras.inc )

		set_vel( proj, vel_x, vel_y )

		ComponentSetValue2( v_comp, 'value_int', paras.frame )
	end
end
