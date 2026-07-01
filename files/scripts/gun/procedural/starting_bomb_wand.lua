dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )
dofile_once( 'data/scripts/gun/procedural/gun_action_utils.lua' )

local init_wand = GetUpdatedEntityID( )
local x, y = EntityGetTransform( init_wand )
local a, b, c = time_for_vec3( )

set_r_seed( init_wand )

local gun = {
	ui_name = 'Bolt staff',
	item_name = '$item_wand_starting_wand_blue',
	mana_max = { },
}

local ability = {
	deck_capacity = { 2, 5 },
	actions_per_round = 1,
	shuffle_deck_when_empty = false,
	fire_rate_wait = { 2, 10 },
	reload_time = { 0, 12 },
	spread_degrees = 0,
	speed_multiplier = 1,
}

ability.deck_capacity = get_random_between_range( ability.deck_capacity )
ability.fire_rate_wait = get_random_between_range( ability.fire_rate_wait )
ability.reload_time = get_random_between_range( ability.reload_time )

local gun_actions = {
	{ 'BOMB', 25 }, { 'EMPTY_STICKY_BOMB', 30 }, { 'EMPTY_BOUNCY_BOMB', 30 },
	{ 'DYNAMITE', 50 }, { 'EMPTY_STICKY_DYNAMITE', 60 }, { 'EMPTY_BOUNCY_DYNAMITE', 60 },
	{ 'MINE', 20 }, { 'MINE_DEATH_TRIGGER', 20 },
	{ 'ROCKET', 70 }, { 'ROCKET_TIER_2', 90 }, { 'ROCKET_TIER_3', 120 },
	{ 'GRENADE_TIER_2', 90 }, { 'GRENADE_TIER_3', 90 },
	{ 'BLACK_HOLE', 180 }, { 'WHITE_HOLE', 180 },
}

local total_mana = 0

for _ = 1, ability.deck_capacity, 1 do
	local card = get_random_from( gun_actions )

	AddGunAction( init_wand, card[ 1 ] )

	if ( total_mana < card[ 2 ] ) then
		total_mana = card[ 2 ]
	end
end

gun.mana_max[ 1 ] = total_mana * 1.2
gun.mana_max[ 2 ] = total_mana * 2.4

local mana_max = get_random_between_range( gun.mana_max )

local mana_mul = get_log_mul( mana_max, {
	min_num = 100,
	max_num = 660,
	min_log = 1.2,
	max_log = 0.5,
	log_e = 0.5,
} )

gun.mana_max = math.ceil( mana_max * mana_mul )
gun.mana = gun.mana_max
gun.mana_charge_speed = math.ceil( gun.mana_max / 6 )

gun = convert_any_air( gun )

set_comp_value( init_wand, 'AbilityComponent', nil, gun, nil, nil )

local add, del = { }, { }

for k, v in pairs( ability ) do
	if ( type( k ) == 'string' and tonumber( k ) == nil ) then
		if ( is_in( k, { 'fire_rate_wait', 'spread_degrees', 'speed_multiplier' } ) ) then
			table.insert( add, { 'gunaction_config', k, v } )
		else
			table.insert( add, { 'gun_config', k, v } )
		end

		table.insert( del, k )
	end
end

for i, _ in ipairs( del ) do
	ability[ _ ] = nil
end

for i, _ in ipairs( add ) do
	table.insert( ability, _ )
end

set_comp_obj_value( init_wand, 'AbilityComponent', nil, ability, nil, nil )
