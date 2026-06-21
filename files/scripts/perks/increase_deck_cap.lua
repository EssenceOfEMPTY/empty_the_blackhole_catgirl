dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local cap_mul = get_globals_num( 'EMPTY_DECK_CAP_MULTIPLIER', 1 )

if ( cap_mul == 1 or cap_mul < 0 ) then
	return
end

set_r_seed( )

local wands, tag = EntityGetWithTag( 'wand' ), 'deck_cap'

set_comp_obj_value( wands, 'AbilityComponent', nil, nil, nil, function ( comp )
	local wand = comp_get_entity( comp )

	if ( EntityHasTag( wand, tag ) ) then
		return
	else
		EntityAddTag( wand, tag )

		local real_cap = get_real_cap( wand )

		real_cap = math.min( math.ceil( real_cap * cap_mul ) + Random( 0, math.floor( cap_mul ) ), 30 )

		adjust_wand_deck( wand, {
			real_set = real_cap,
		} )
	end
end )
