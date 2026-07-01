dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local chest = GetUpdatedEntityID( )
local x, y = EntityGetTransform( chest )

local keys = EntityGetInRadiusWithTag( x, y, 24, 'alchemist_key' )

if ( #keys > 0 ) then
	local key = keys[ 1 ]

	local variables = EntityGetComponent( key, 'VariableStorageComponent' )
	local status = 0

	if ( variables ) then
		for i,comp in ipairs(variables) do
			local name = ComponentGetValue2( comp, 'name' )

			if ( name == 'music_machine' ) then
				status = ComponentGetValue2( comp, 'value_int' )
			end
		end
	end

	local already_done = HasFlagPersistent( 'card_unlocked_musicbox' )

	if ( status == 4 ) then
		local opts = {
			'DIVIDE_2', 'DIVIDE_3', 'DIVIDE_4', 'BURST_8', 'BURST_X',
			'EMPTY_DIVIDE_2-', 'EMPTY_DIVIDE_3-', 'EMPTY_DIVIDE_4-',
			'EMPTY_DIVIDE_2+', 'EMPTY_DIVIDE_3+', 'EMPTY_DIVIDE_4+',
		}

		if ( already_done == false ) then
			GamePrintImportant( '$log_alchemist_key_alt_reward', '$logdesc_alchemist_key_alt_reward' )
			EntitySetComponentsWithTagEnabled( chest, 'chest_enable', true )
			EntitySetComponentsWithTagEnabled( chest, 'chest_disable', false )

			for _, each in ipairs( opts ) do
				CreateItemActionEntity( each, x + loc_center_fix( #opts, 16, _ ), y )
			end

			AddFlagPersistent( 'card_unlocked_musicbox' )
		else
			GamePrintImportant( '$log_alchemist_chest_opened_alt', '$logdesc_alchemist_chest_opened_alt' )
			set_r_seed( chest )

			local count = 5

			for _ = 1, count do
				local rnd = Random( 1, #opts )

				CreateItemActionEntity( opts[ rnd ], x + loc_center_fix( count, 24, _ ), y )

				table.remove( opts, rnd )
			end
		end

		AddFlagPersistent( 'secret_chest_light' )

		EntityLoad( 'data/entities/particles/particle_explosion/main_swirly_green.xml', x, y )
		EntityLoad( 'data/entities/projectiles/circle_water.xml', x, y )

		GamePlaySound( 'data/audio/Desktop/misc.bank', 'misc/chest_dark_open', x, y )

		EntityKill( key )
		EntityKill( chest )
	end
end
