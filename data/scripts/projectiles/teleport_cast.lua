dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local proj	= GetUpdatedEntityID()
local x, y = EntityGetTransform( proj )

local targets = EntityGetInRadiusWithTag( x, y, 96, 'homing_target' )

set_r_seed( proj )

if ( #targets > 0 ) then
	local rnd = Random( 1, #targets )
	local tar = targets[ rnd ]

	if ( EntityHasTag( tar, 'teleportable_NOT' ) ) then
		return
	end

	local tx, ty = EntityGetTransform( tar )

	tp( proj, tx, ty )
end
