dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local trigger = GetUpdatedEntityID( )
local x, y = EntityGetTransform( trigger )

local test1 = EntityGetInRadiusWithTag( x, y, 64, 'player_unit' )
local test2 = EntityGetInRadiusWithTag( x, y, 64, 'small_friend' )
local test3 = EntityGetInRadiusWithTag( x, y, 64, 'big_friend' )

if ( #test2 > 0 ) then
	CreateItemActionEntity( 'NUKE_GIGA', x, y )
	AddFlagPersistent( 'card_unlocked_nukegiga' )
	EntityLoad( 'data/entities/projectiles/deck/nuke.xml', x, y )
	AddFlagPersistent( 'final_secret_orb' )

	EntityKill( trigger )
elseif ( #test3 > 0 ) then
	CreateItemActionEntity( 'BOMB_HOLY_GIGA', x, y )
	AddFlagPersistent( 'card_unlocked_bomb_holy_giga' )
	EntityLoad( 'data/entities/projectiles/deck/nuke.xml', x, y )
	AddFlagPersistent( 'final_secret_orb2' )

	EntityKill( trigger )
elseif GameHasFlagRun( 'greed_curse' ) and ( GameHasFlagRun( 'greed_curse_gone' ) == false ) and ( #test1 > 0 ) then
	local opts = {
		'DIVIDE_10',
	}

	if ( get_setting_by_def( 'EFFECT_CHANGE_DIAMOND_DIVIDE' ) ) then
		opts = {
			'EMPTY_DIVIDE_10+',
			'DIVIDE_10',
			'EMPTY_DIVIDE_10-',
		}
	end

	for _ = 1, #opts, 1 do
		CreateItemActionEntity( opts[ _ ], x + loc_center_fix( #opts, 16, _ ), y )
	end

	AddFlagPersistent( 'card_unlocked_divide' )

	EntityKill( trigger )
elseif ( #test1 > 0 ) then
	CreateItemActionEntity( 'AIR_BULLET', x, y )

	EntityKill( trigger )
end
