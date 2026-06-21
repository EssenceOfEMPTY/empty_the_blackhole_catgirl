dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local niko = get_root_entity( )

local greed = get_all_child( niko, 'greed_curse', nil )

if ( #greed > 0 ) then
	for i, _ in ipairs( greed ) do
		if ( not EntityHasTag( _, 'greed_curse_clean' ) ) then
			EntityAddTag( _, 'greed_curse_clean' )

			remove_all_comp( _, 'LuaComponent', nil, nil )
		end
	end

	remove_all_comp( niko, 'LuaComponent', 'greed_protect', nil )
end
