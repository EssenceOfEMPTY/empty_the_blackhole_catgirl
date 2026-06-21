dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local mana_mul = get_globals_num( 'EMPTY_MANA_REG_MULTIPLIER', 1 )

if ( mana_mul == 1 ) then
	return
end

local wands, tag = EntityGetWithTag( 'wand' ), 'mana_reg'

set_comp_value( wands, 'AbilityComponent', nil, nil, nil, function ( comp )
	local wand = comp_get_entity( comp )

	if ( EntityHasTag( wand, tag ) ) then
		return
	else
		EntityAddTag( wand, tag )

		local mana_reg = ComponentGetValue2( comp, 'mana_charge_speed' )

		ComponentSetValue2( comp, 'mana_charge_speed', mana_reg * mana_mul )
	end
end )
