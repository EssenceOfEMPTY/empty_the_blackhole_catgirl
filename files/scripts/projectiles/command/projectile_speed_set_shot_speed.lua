dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_command_utility.lua' )

local command = 'projectile_speed_set'
local command_shot_speed = command .. '_shot_speed'

function shot( proj )
	if ( EntityHasTag( proj, command_shot_speed ) ) then
		local varia_comps = EntityGetComponent( proj, 'VariableStorageComponent', command_shot_speed )

		for _, varia_comp in ipairs( varia_comps or { } ) do
			local speed = ComponentGetValue2( varia_comp, 'value_float' )

			local vel_x, vel_y = get_vel( proj )

			vel_x, vel_y = change_vel( vel_x, vel_y, speed )

			set_vel( proj, vel_x, vel_y )

			count = count + 1

			EntityRemoveComponent( proj, varia_comp )
		end
	end
end
