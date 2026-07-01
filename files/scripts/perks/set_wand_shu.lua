dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local wand_shu = get_global_num( 'EMPTY_WAND_SHU', 0 )

if ( wand_shu == 0 ) then
	return
end

local wands, tag = EntityGetWithTag( 'wand' ), 'wand_shu'
local op_wands = { }

set_r_seed( get_root_entity( ) )

for i, _ in ipairs( wands ) do
	if ( not EntityHasTag( _, tag ) ) then
		EntityAddTag( _, tag )

		table.insert( op_wands, _ )
	end
end

if ( #op_wands > 0 ) then
	if ( wand_shu > 0 ) then
		set_comp_obj_value( op_wands, 'AbilityComponent', nil, {
			{ 'gun_config', 'shuffle_deck_when_empty', false },
		}, nil, nil )
	else
		set_comp_obj_value( op_wands, 'AbilityComponent', nil, {
			{ 'gun_config', 'shuffle_deck_when_empty', true },
		}, nil, nil )
	end
end
