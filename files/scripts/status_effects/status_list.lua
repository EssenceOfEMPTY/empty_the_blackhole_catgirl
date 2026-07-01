dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local icon_url = empty_path .. 'ui_gfx/status_indicators/'
local eff_entity_url = empty_path .. 'entities/misc/game_effects/effect_'

local new_effects = {
	{
		info = 'toxic',
		is_harmful = true,
	},
}

for i, _ in ipairs( new_effects ) do
	if ( is_not_nil_str( _.info ) ) then
		local info = string.lower( _.info )
		local e_info = 'empty_' .. info

		_.id					= string.upper( e_info )
		_.ui_name				= '$status_' .. e_info
		_.ui_description		= '$statusdesc_' .. e_info
		_.ui_icon				= icon_url .. info .. '.png'
		_.effect_entity			= eff_entity_url .. info .. '.xml'
		_.info					= nil
	end
end

add_table( status_effects, new_effects )
