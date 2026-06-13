dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local proj = get_root_entity( )
local command = 'projectile_shoot_angle_add'
local command_delay = command .. '_delay'

if ( proj ~= NULL_ENTITY ) then
	local varia_comps = EntityGetComponent( proj, 'VariableStorageComponent', command_delay )
	local count = 0

	for i, varia_comp in ipairs( varia_comps or { } ) do
		local angle = ComponentGetValue2( varia_comp, 'value_float' )

		local vel_x, vel_y = get_vel( proj )

		vel_x, vel_y = rot_vel( vel_x, vel_y, angle )

		set_vel( proj, vel_x, vel_y )

		count = count + 1

		EntityRemoveComponent( proj, varia_comp )
	end

	if ( count > 0 ) then
		command_print( command .. '(', '$empty_command_projectile_change_success', tostring( count ) )
	else
		command_print( command .. '(', '$empty_command_error_no_projectile_change' )
	end
end
