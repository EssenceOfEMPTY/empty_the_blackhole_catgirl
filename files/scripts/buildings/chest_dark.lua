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

			if ( name == 'status' ) then
				status = ComponentGetValue2( comp, 'value_int' )
			end
		end
	end

	local already_done = HasFlagPersistent( 'card_unlocked_alchemy' )

	if ( status == 2 ) then
		local opts = {
			'ALL_ACID', 'ALL_NUKES', 'ALL_DISCS', 'ALL_ROCKETS', 'ALL_BLACKHOLES', 'ALL_DEATHCROSSES',
			'EMPTY_ALL_GIGA_BLACKHOLE', 'EMPTY_ALL_GIGA_WHITEHOLE',
			'EMPTY_ALL_EMPTY',
		}

		if ( already_done == false ) then
			GamePrintImportant( '$log_alchemist_chest_open', '$logdesc_alchemist_chest_open' )
			EntitySetComponentsWithTagEnabled( chest, 'chest_enable', true )
			EntitySetComponentsWithTagEnabled( chest, 'chest_disable', false )

			for _, each in ipairs( opts ) do
				CreateItemActionEntity( each, x + loc_center_fix( #opts, 16, _ ), y )
			end

			AddFlagPersistent( 'card_unlocked_alchemy' )
		else
			GamePrintImportant( '$log_alchemist_chest_opened', '$logdesc_alchemist_chest_opened' )
			set_r_seed( chest )

			local count = 5

			for _ = 1, count do
				local rnd = Random( 1, #opts )

				CreateItemActionEntity( opts[ rnd ], x + loc_center_fix( count, 24, _ ), y )

				table.remove( opts, rnd )
			end
		end

		AddFlagPersistent( 'secret_chest_dark' )

		EntityLoad( 'data/entities/particles/particle_explosion/main_swirly_red.xml', x, y )
		EntityLoad( 'data/entities/projectiles/circle_blood.xml', x, y )

		GamePlaySound( 'data/audio/Desktop/misc.bank', 'misc/chest_dark_open', x, y )

		EntityKill( key )
		EntityKill( chest )
	end
end
