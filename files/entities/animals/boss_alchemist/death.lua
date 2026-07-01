dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

function death( dmg, dmg_message, res, drop_items )
	local alchemist = get_root_entity( )
	local x, y = EntityGetTransform( alchemist )

	set_r_seed( alchemist )

	local flag_status = HasFlagPersistent( 'card_unlocked_duplicate' )

	local opts = {
		'ALPHA', 'GAMMA', 'TAU', 'OMEGA', 'MU', 'PHI', 'SIGMA', 'ZETA',--[[ 'EMPTY_PHI-', 'EMPTY_SIGMA-',]]--

		'EMPTY_ALPHA+', 'EMPTY_GAMMA+', 'EMPTY_TAU+', 'EMPTY_OMEGA+', 'EMPTY_MU+', 'EMPTY_PHI+', 'EMPTY_SIGMA+', 'EMPTY_ZETA+',
			'EMPTY_BETA+', 'EMPTY_LAMBDA+', 'EMPTY_CHI+', 'EMPTY_THETA+', 'EMPTY_OMICRON+',

		'EMPTY_ALPHA-', 'EMPTY_GAMMA-', 'EMPTY_TAU-', 'EMPTY_OMEGA-', 'EMPTY_MU-', 'EMPTY_ZETA-',
			'EMPTY_BETA-', 'EMPTY_LAMBDA-', 'EMPTY_CHI-', 'EMPTY_THETA-', 'EMPTY_OMICRON-',
	}

	local count = 7

	for _ = 1, count do
		local rnd = Random( 1, #opts )

		CreateItemActionEntity( opts[ rnd ], x + loc_center_fix( count, 16, _ ), y )

		table.remove( opts, rnd )
	end

	if ( not flag_status ) then
		EntityLoad( 'data/entities/items/pickup/heart_fullhp.xml',  x, y )
	end

	EntityLoad( 'data/entities/animals/boss_alchemist/key.xml',  x, y )

	AddFlagPersistent( 'card_unlocked_duplicate' )
	AddFlagPersistent( 'miniboss_alchemist' )
end
