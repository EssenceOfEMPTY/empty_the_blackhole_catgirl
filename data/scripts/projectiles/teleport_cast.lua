dofile_once( 'data/scripts/lib/utilities.lua' )

local proj	= GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( proj )

local targets = EntityGetInRadiusWithTag( pos_x, pos_y, 96, 'homing_target' )

SetRandomSeed( pos_x + pos_y, GameGetFrameNum( ) )

if ( #targets > 0 ) then
	local rnd = Random( 1, #targets )
	local tar = targets[ rnd ]

	if ( EntityHasTag( tar, 'teleportable_NOT' ) ) then
		return
	end

	local tx, ty = EntityGetTransform( tar )

	tp( proj, tx, ty )
end
