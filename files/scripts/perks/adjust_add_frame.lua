dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local entity, tag = get_root_entity( ), 'empty_adjust'

local count = get_comp_info( entity, 'VariableStorageComponent', tag, {
	{ 'value_int', 0 }
}, nil )

if ( count < 180 ) then
	local delta = tonumber( GlobalsGetValue( 'EMPTY_ADJUST_COUNT', '0' ) ) + 1

	set_comp_value( entity, 'VariableStorageComponent', tag, {
		value_int = math.min( count + delta, 180 ),
	}, nil, nil )
end
