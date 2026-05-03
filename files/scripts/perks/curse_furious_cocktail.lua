dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_effect_utility.lua' )

local entity = EntityGetRootEntity( GetUpdatedEntityID( ) )

if ( entity ~= NULL_ENTITY ) then
	info_print( entity, 'entity: curse_furious_cocktail.lua' )
	add_effect_random( entity, 1620, 1080, '$empty_title_furious_cocktail' )
end
