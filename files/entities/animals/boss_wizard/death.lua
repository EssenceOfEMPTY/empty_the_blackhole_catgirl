dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

function death( dmg, dmg_message, res, drop_items )
	local wizard = get_root_entity( )
	local x, y = EntityGetTransform( wizard )

	local opts = {
		'ADD_TRIGGER', 'ADD_TIMER', 'ADD_DEATH_TRIGGER',

		'DUPLICATE',

		'RESET',

		'EMPTY_X2', 'EMPTY_ARRIVAL', 'EMPTY_DEPARTURE',
		'EMPTY_RETURN',
	}

	for _ = 1, #opts, 1 do
		CreateItemActionEntity( opts[ _ ], x + loc_center_fix( #opts, 16, _ ), y )
	end

	EntityLoad( 'data/entities/items/books/book_mestari.xml',  x - 24, y )
	EntityLoad( 'data/entities/items/pickup/wandstone.xml',  x + 24, y )

	AddFlagPersistent( 'card_unlocked_mestari' )
	AddFlagPersistent( 'miniboss_wizard' )

	local mat = get_comp_value( wizard, 'DamageModelComponent', nil, {
		{ 'mLiquidMaterialWeAreIn', 0 },
	}, nil )

	if ( is_not_0_num( mat ) ) then
		local mat_str = CellFactory_GetName( mat )

		if ( dmg_message == '$damage_drowning' and mat_str == 'swamp' ) then
			CreateItemActionEntity( 'HOMING_WAND', x, y - 64 )

			AddFlagPersistent( 'card_unlocked_homing_wand' )
		end
	end
end
