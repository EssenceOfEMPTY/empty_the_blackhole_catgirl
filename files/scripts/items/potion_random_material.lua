dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

function init( potion )
	set_r_seed( potion )

	local mat, vol = get_random_mat( ), 1000

	if ( get_setting_by_def( 'EFFECT_CHANGE_POTION_VOLUME' ) ) then
		vol = 2000
	end

	AddMaterialInventoryMaterial( potion, mat, vol )
end
