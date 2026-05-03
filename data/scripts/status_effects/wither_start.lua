dofile_once( 'data/scripts/lib/utilities.lua' )

local entity = EntityGetRootEntity( GetUpdatedEntityID( ) )

if ( entity ~= NULL_ENTITY ) then
	local comp = EntityGetFirstComponent( entity, 'DamageModelComponent' )

	local resists = { 'drill', 'electricity', 'explosion', 'fire', 'ice', 'melee', 'projectile', 'radioactive', 'slice' }

	if ( comp ) then
		for a, b in ipairs( resists ) do
			local multipliers = ComponentObjectGetValue2( comp, 'damage_multipliers', b )

			if ( multipliers < 0 ) then
				multipliers = 1
			end

			ComponentObjectSetValue2( comp, 'damage_multipliers', b, multipliers + 1 )
		end
	end

	local c = EntityGetAllChildren( entity )

	for _, v in ipairs( c or { } ) do
		if EntityHasTag( v, 'effect_resistance' ) then
			EntitySetComponentsWithTagEnabled( v, 'effect_resistance', false )
		end
	end
end
