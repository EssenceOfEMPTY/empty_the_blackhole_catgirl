dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local niko = get_root_entity( )

local all_stains = get_comp_value( niko, 'StatusEffectDataComponent', nil, {
	{ 'stain_effects', { } }
}, nil )

info_print( all_stains, 'all_stains' )
