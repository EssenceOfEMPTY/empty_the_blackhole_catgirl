dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local tag = 'aff_in_inv'
local stones = get_all_entity( 'item_pickup', tag )

for i, _ in ipairs( stones ) do
	local i_name = get_comp_value( _, 'ItemComponent', 'enabled_in_world', {
		{ 'item_name', '' },
	}, nil )

	if ( string.match( i_name, '^%$item_[a-z]+stone$' ) ) then
		set_comp_value( _, nil, 'enabled_in_hand', nil, function ( comp )
			if ( not is_exposing_comp( comp ) ) then
				ComponentAddTag( comp, 'enabled_in_inventory' )
			end
		end, nil, nil )
	end

	EntityAddTag( _, tag )
end
