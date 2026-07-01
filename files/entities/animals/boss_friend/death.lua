dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

function death( dmg, dmg_message, res, drop_items )
	local friend = get_root_entity( )
	local x, y = EntityGetTransform( friend )

	local opts = {
		'EMPTY_COLORFUL_ITER_PROJECTILE_BUCKSHOT', 'EMPTY_COLORFUL_REC_ITER_PROJECTILE_CHAINSAW', 'EMPTY_COLORFUL_REC_ITER_PROJECTILE_HOLE',

		'EMPTY_COLORFUL_REC_MODIFIER_COMPLEX',

		'EMPTY_COLORFUL_X2', 'EMPTY_COLORFUL_ARRIVAL', 'EMPTY_COLORFUL_DEPARTURE',
		'EMPTY_COLORFUL_RETURN',
	}

	for _ = 1, #opts, 1 do
		CreateItemActionEntity( opts[ _ ], x + loc_center_fix( #opts, 16, _ ), y )
	end

	AddFlagPersistent( 'card_unlocked_colorful' )

	local ct = get_global_num( 'ULTIMATE_KILLER_KILLS', 0 )

	if ( ct >= 9 ) then
		AddFlagPersistent( "final_secret_orb3" )
	end
end
