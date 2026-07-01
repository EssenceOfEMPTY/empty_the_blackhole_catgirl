dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local cast_mul = get_global_num( 'EMPTY_CAST_DEL_MULTIPLIER', 1 )
local cast_abs = get_global_num( 'EMPTY_CAST_DEL_ABS', 0 )

if ( cast_mul == 1 and cast_abs > 0 ) then
	return
end

local wands, tag = EntityGetWithTag( 'wand' ), 'cast_del'

set_r_seed( get_root_entity( ) )

for i, _ in ipairs( wands ) do
	if ( not EntityHasTag( _, tag ) ) then
		EntityAddTag( _, tag )

		local delay, reload = get_wand_delay( _ )

		delay = math.ceil( delay * cast_mul ) + Random( math.floor( cast_mul ) )
		reload = math.ceil( reload * cast_mul ) + Random( math.floor( cast_mul ) )

		if ( cast_abs > 0 ) then
			delay, reload = math.abs( delay ), math.abs( reload )
		elseif ( cast_abs < 0 ) then
			delay, reload = -math.abs( delay ), -math.abs( reload )
		end

		set_wand_delay( _, delay, reload )
	end
end
