dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local death = tonumber( StatsGlobalGetValue( 'death_count' ) ) or 0

function damage_about_to_be_received( dmg, x, y, res, cri_chance )
	if ( dmg > 0 ) then
		return dmg / ( 300 * cap( 1, death, 10 ) ), cri_chance
	else
		return dmg, cri_chance
	end
end
