dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local entity = GetUpdatedEntityID( )
local player = EntityGetRootEntity( entity )

local x, y = EntityGetTransform( entity )
y = y - 4

local orbdata = orb_map_get( )
local pw, mx = check_parallel_pos( x )

local timercomp = get_all_comp( entity, 'VariableStorageComponent', nil, 'map_timer' )[ 1 ]
local timer = ComponentGetValue2( timercomp, 'value_int' ) or 0

if ( timercomp ) and ( entity ~= player ) then
	local is_moving = false
	component_read( EntityGetFirstComponent( player, 'ControlsComponent' ), {
		mButtonDownDown = false,
		mButtonDownUp = false,
		mButtonDownLeft = false,
		mButtonDownRight = false,
		mButtonDownJump = false,
		mButtonDownFire = false,
	}, function( ctrl )
		is_moving = ctrl.mButtonDownDown or ctrl.mButtonDownUp or ctrl.mButtonDownLeft or ctrl.mButtonDownRight or ctrl.mButtonDownJump or ctrl.mButtonDownFire or false
	end )

	if ( is_moving == false ) then
		timer = math.min( timer + 1, 160 )

		if ( timer > 80 ) then
			local map_sprite = 'spatial_map_1'
			local map_x = 0 * 512
			local map_y = 10 * 512

			local mult_x = 512 / 6.0
			local mult_y = 512 / 6.0

			local dx = math.min( math.max( ( map_x - mx ) / mult_x, -420 ), 420 )
			local dy = math.min( math.max( ( map_y - y ) / mult_y, -240 ), 240 )

			local mi_x = x + dx * 0.5
			local mi_y = y + dy * 0.5

			local pi_x = x - dx * 0.5
			local pi_y = y - dy * 0.5

			if ( timer > 86 ) then
				map_sprite = 'spatial_map_4'
			elseif ( timer > 84 ) then
				map_sprite = 'spatial_map_3'
			elseif ( timer > 82 ) then
				map_sprite = 'spatial_map_2'
			end

			set_r_seed( player )

			local fspot = Random( 1, 6 )
			local fspots = { { 249, 153 }, { 261, 201 }, { 153, 141 }, { 87, 135 }, { 81, 219 }, { 153, 237 } }

			local fdata = fspots[ fspot ]
			local fx, fy = fdata[ 1 ], fdata[ 2 ]

			fx, fy = fx - 420 * 0.5, fy - 288 * 0.5

			GameCreateSpriteForXFrames( 'data/particles/' .. map_sprite .. '.png', mi_x, mi_y, true, 0, 0, 1, true )
			GameCreateSpriteForXFrames( 'data/particles/spatial_map_player.png', pi_x, pi_y, true, 0, 0, 1, true )
			GameCreateSpriteForXFrames( 'data/particles/spatial_map_friend.png', mi_x + fx, mi_y + fy, true, 0, 0, 1, true )

			if ( pw ~= 0 ) then
				local name = 'spatial_map_pw_'

				if ( pw > 0 ) then
					name = name .. tostring( math.min( 4, pw ) )
				elseif ( pw < 0 ) then
					name = name .. 'm' .. tostring( math.min( 4, math.abs( pw ) ) )
				end

				GameCreateSpriteForXFrames( 'data/particles/' .. name .. '.png', mi_x + 6, mi_y - 92, true, 0, 0, 1, true )
			end

			for i, v in ipairs( orbdata ) do
				local ox = v[ 1 ] * 6 + 3
				local oy = v[ 2 ] * 6 - 56

				GameCreateSpriteForXFrames( 'mods/empty_the_blackhole_catgirl/files/ui_gfx/map_orb.png', mi_x + ox, mi_y + oy, true, 0, 0, 1, true )
			end
		end
	else
		timer = 0
	end

	ComponentSetValue2( timercomp, 'value_int', timer )
end
