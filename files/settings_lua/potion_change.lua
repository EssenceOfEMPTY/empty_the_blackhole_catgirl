dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local tag = 'potion_change'
local potions = get_all_entity( 'potion', tag )

if ( #potions <= 0 ) then
	return
end

if ( get_setting_by_def( 'EFFECT_CHANGE_POTION_HP' ) ) then
	set_comp_value( potions, 'DamageModelComponent', nil, {
		{ 'max_hp', 400 / get_scale( ) },
		{ 'hp', 400 / get_scale( ) },
	}, nil, nil )
end

if ( get_setting_by_def( 'EFFECT_CHANGE_POTION_HIGH_EXPLOSION' ) ) then
	set_comp_value( potions, 'ExplodeOnDamageComponent', nil, {
		{ 'damage', 325 / get_scale( ) },
		{ 'explosion_radius', 64 },
	}, nil, nil )
end

for i, _ in ipairs( potions ) do
	EntityAddTag( _, tag )
end
