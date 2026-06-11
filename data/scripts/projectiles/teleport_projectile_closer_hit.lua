dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local proj = get_up_entity( )
local x, y = EntityGetTransform( proj )
local enemy = EntityGetRootEntity( proj )

if ( is_not_0_num( enemy ) and EntityHasTag( enemy, 'teleportable_NOT' ) ) then
	return
end

local projectiles = EntityGetInRadiusWithTag( x, y, 32, 'teleport_projectile_closer' )

if ( #projectiles > 0 ) then
	local pid = projectiles[ 1 ]
	local comps = EntityGetComponent( pid, 'VariableStorageComponent', 'teleport_closer' )

	for i, _ in ipairs( comps or { } ) do
		local n = ComponentGetValue2( _, 'name' )

		if ( n == 'origin_x' ) then
			ox = ComponentGetValue2( _, 'value_float' )
		elseif ( n == 'origin_y' ) then
			oy = ComponentGetValue2( _, 'value_float' )
		end
	end

	if ( ox ) and ( oy ) then
		tp( enemy, ox, oy )
	end
end
