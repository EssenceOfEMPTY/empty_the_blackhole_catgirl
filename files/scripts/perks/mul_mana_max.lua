dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local mana_mul = get_global_num( 'EMPTY_MANA_MAX_MULTIPLIER', 1 )

if ( mana_mul == 1 ) then
	return
end

local wands, tag = EntityGetWithTag( 'wand' ), 'mana_max'

set_r_seed( get_root_entity( ) )

for i, _ in ipairs( wands ) do
	if ( not EntityHasTag( _, tag ) ) then
		EntityAddTag( _, tag )

		local mana_max = get_comp_value( _, 'AbilityComponent', nil, {
			{ 'mana_max', 0 },
		}, nil )

		mana_max = math.ceil( mana_max * mana_mul ) + Random( math.floor( mana_mul ) )

		local aff = set_comp_value( _, 'AbilityComponent', nil, {
			{ 'mana_max', mana_max },
		}, nil, nil )

	end
end
