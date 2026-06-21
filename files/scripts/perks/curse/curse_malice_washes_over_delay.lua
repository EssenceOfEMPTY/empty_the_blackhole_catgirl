dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local tar, tag = get_root_entity( ), 'CURSE_MALICE_WASHES_OVER'

if ( is_not_0_num( tar ) ) then
	local x, y = get_comp_value( tar, 'VariableStorageComponent', tag, {
		{ 'value_float', 0 },
		{ 'value_string', '0' },
	}, nil )

	y = tonumber( y ) or 0

	local e = EntityLoad( empty_path .. 'entities/misc/curse/curse_malice_washes_over.xml', x, y )

	EntityAddChild( tar, e )

	remove_all_comp( tar, 'VariableStorageComponent', tag, nil )
end
