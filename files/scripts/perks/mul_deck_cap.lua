dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local cap_mul = get_global_num( 'EMPTY_DECK_CAP_MULTIPLIER', 1 )

if ( cap_mul == 1 or cap_mul < 0 ) then
	return
end

local wands, tag = EntityGetWithTag( 'wand' ), 'deck_cap'

set_r_seed( get_root_entity( ) )

local is_curse = get_global_num( 'EMPTY_CURSE_SHORT_WAND', 0 )

if ( is_curse == 0 ) then
	for i, _ in ipairs( wands ) do
		if ( not EntityHasTag( _, tag ) ) then
			EntityAddTag( _, tag )

			local real_cap = get_real_cap( _ )

			real_cap = cap( 1, math.ceil( real_cap * cap_mul ) + Random( math.floor( cap_mul ) ), max_deck_cap )

			adjust_wand_deck( _, {
				real_set = real_cap,
			} )
		end
	end
else
	local curse_tag = 'deck_cap_cursed'

	for i, _ in ipairs( wands ) do
		local is_has_1, is_has_2 = EntityHasTag( _, tag ), EntityHasTag( _, curse_tag )
		local deck_cap = nil

		if ( not is_has_1 ) then
			EntityAddTag( _, tag )

			local real_cap = get_real_cap( _ )

			deck_cap = cap( 1, math.ceil( real_cap * cap_mul ) + Random( math.floor( cap_mul ) ), max_deck_cap )
		end

		if ( not is_has_2 ) then
			EntityAddTag( _, curse_tag )

			local real_cap = deck_cap or get_real_cap( _ )

			deck_cap = mod_cap( 1, real_cap, 7 )
		end

		if ( is_not_nan_num( deck_cap ) ) then
			adjust_wand_deck( _, {
				real_set = deck_cap,
			} )
		end
	end
end
