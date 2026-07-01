dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local mana_mul = get_global_num( 'EMPTY_MANA_REG_MULTIPLIER', 1 )

if ( mana_mul == 1 ) then
	return
end

local wands, tag = EntityGetWithTag( 'wand' ), 'mana_reg'

set_r_seed( get_root_entity( ) )

for i, _ in ipairs( wands ) do
	if ( not EntityHasTag( _, tag ) ) then
		EntityAddTag( _, tag )

		local mana_reg = get_comp_value( _, 'AbilityComponent', nil, {
			{ 'mana_charge_speed', 0 },
		}, nil )

		mana_reg = math.ceil( mana_reg * mana_mul ) + Random( math.floor( mana_mul ) )

		set_comp_value( _, 'AbilityComponent', nil, {
			{ 'mana_charge_speed', mana_reg },
		}, nil, nil )
	end
end
