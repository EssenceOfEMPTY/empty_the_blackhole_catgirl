dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

edit_component( GameGetWorldStateEntity(), "WorldStateComponent", function(comp,vars)
		vars.damage_flash_multiplier = 0.0
end)

EntityLoad( "data/entities/animals/boss_centipede/ending/midas_entities.xml", x, y )
