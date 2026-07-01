dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local tar, tag = get_root_entity( ), 'CURSE_MALICE_WASHES_OVER'

if ( is_not_0_num( tar ) ) then
	local x, y = get_comp_value( tar, 'VariableStorageComponent', tag, {
		{ 'value_float', 0 },
		{ 'value_string', '0' },
	}, nil )

	y = tonumber( y ) or 0

	add_comp_remove_dupli( tar, 'VariableStorageComponent', tag .. '_ACTIVE', {
		{ '_tags', tag .. '_ACTIVE' },
		{ 'value_int', 1 },
	} )

	local e = EntityLoad( empty_path .. 'entities/misc/curse/curse_malice_washes_over.xml', x, y )

	add_comp_remove_dupli( e, 'VariableStorageComponent', tag, {
		{ '_tags', tag },
		{ 'value_int', tar },
	} )

	add_comp_remove_dupli( tar, 'VariableStorageComponent', tag .. '_CLOUD', {
		{ '_tags', tag .. '_CLOUD' },
		{ 'value_int', e },
	} )
end
