dofile_once( 'data/scripts/magic/fungal_shift.lua' )
dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local ui_icon_url = empty_path .. 'ui_gfx/perk_icons/'
local perk_icon_url = empty_path .. 'items_gfx/perks/'

local new_perks =
{
	{
		info = 'extract_always_cast',
		stackable = STACKABLE_YES,
		stackable_is_rare = true,
		one_off_effect = true,
		usable_by_enemies = false,
		func = function( perk_item, who, item_name )
			local invs = get_all_child( who, 'inventory_quick' )

			for i, inv in ipairs( invs ) do
				local wand = get_all_child( inv, 'wand', nil )

				for j, _ in ipairs( wand ) do
					local always = get_always( _ )

					adjust_wand_deck( wand, {
						always_set = 0,
						real_delta = always,
					} )
				end
			end
		end,
	},
	{
		info = 'reduce_reroll_count',
		stackable = STACKABLE_YES,
		stackable_is_rare = true,
		max_in_perk_pool = 2,
		one_off_effect = true,
		usable_by_enemies = false,
		func = function( perk_item, who, item_name )
			local reroll_count = get_globals_num( 'TEMPLE_PERK_REROLL_COUNT', 0 )

			GlobalsSetValue( 'TEMPLE_PERK_REROLL_COUNT', tostring( reroll_count - 3 ) )
		end,
		func_remove = function ( who )
			local reroll_count = get_globals_num( 'TEMPLE_PERK_REROLL_COUNT', 0 )

			GlobalsSetValue( 'TEMPLE_PERK_REROLL_COUNT', tostring( reroll_count - 9 ) )
		end,
	},
	{
		info = 'fungal_shift_add_capacity',
		stackable = STACKABLE_YES,
		stackable_is_rare = true,
		max_in_perk_pool = 1,
		one_off_effect = true,
		usable_by_enemies = false,
		func = function( perk_item, who, item_name )
			local shift_count = get_globals_num( 'fungal_shift_iteration', 0 )

			GlobalsSetValue( 'fungal_shift_iteration', tostring( shift_count - 5 ) )
		end,
	},
	{
		info = 'berserk_blood',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		func = function( perk_item, who, item_name )
			set_comp_value( who, 'DamageModelComponent', nil, {
				blood_material = 'magic_liquid_berserk',
				blood_spray_material = 'magic_liquid_berserk',
				blood_sprite_directional = empty_path .. 'particles/bloodsplatters/bloodsplatter_directional_berserk_$[1-3].xml',
				blood_sprite_large = empty_path .. 'particles/bloodsplatters/bloodsplatter_berserk_$[1-3].xml',
			}, function ( comp )
				local blood = ComponentGetValue2( comp, 'blood_multiplier' )

				ComponentSetValue2( comp, 'blood_multiplier', blood * 3 )
			end, nil )
		end,
		func_remove = function ( who )
			set_comp_value( who, 'DamageModelComponent', nil, {
				blood_material = 'blood',
				blood_spray_material = 'blood',
				blood_sprite_directional = empty_path .. 'particles/bloodsplatters/bloodsplatter_directional_$[1-3].xml',
				blood_sprite_large = empty_path .. 'particles/bloodsplatters//bloodsplatter_$[1-3].xml',
			}, function ( comp )
				local blood = ComponentGetValue2( comp, 'blood_multiplier' )

				ComponentSetValue2( comp, 'blood_multiplier', blood / 3 )
			end, nil )
		end,
	},
	{
		info = 'teleport_blood',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		func = function( perk_item, who, item_name )
			set_comp_value( who, 'DamageModelComponent', nil, {
				blood_material = 'magic_liquid_teleportation',
				blood_spray_material = 'magic_liquid_teleportation',
				blood_sprite_directional = empty_path .. 'particles/bloodsplatters/bloodsplatter_directional_teleport_$[1-3].xml',
				blood_sprite_large = empty_path .. 'particles/bloodsplatters/bloodsplatter_teleport_$[1-3].xml',
			}, function ( comp )
				local blood = ComponentGetValue2( comp, 'blood_multiplier' )

				ComponentSetValue2( comp, 'blood_multiplier', blood * 3 )
			end, nil )

			if ( get_globals_num( 'PERK_PICKED_EMPTY_PROTECTION_TELEPORT_PICKUP_COUNT', 0 ) == 0 ) then
				perk_pickup( nil, who, 'EMPTY_PROTECTION_TELEPORT', false, false, true )
			end
		end,
		func_remove = function ( who )
			set_comp_value( who, 'DamageModelComponent', nil, {
				blood_material = 'blood',
				blood_spray_material = 'blood',
				blood_sprite_directional = empty_path .. 'particles/bloodsplatters/bloodsplatter_directional_$[1-3].xml',
				blood_sprite_large = empty_path .. 'particles/bloodsplatters//bloodsplatter_$[1-3].xml',
			}, function ( comp )
				local blood = ComponentGetValue2( comp, 'blood_multiplier' )

				ComponentSetValue2( comp, 'blood_multiplier', blood / 3 )
			end, nil )
		end,
	},
	{
		info = 'freeze_blood',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		func = function( perk_item, who, item_name )
			set_comp_value( who, 'DamageModelComponent', nil, {
				blood_material = 'blood_cold',
				blood_spray_material = 'blood_cold',
				blood_sprite_directional = empty_path .. 'particles/bloodsplatters/bloodsplatter_directional_freeze_$[1-3].xml',
				blood_sprite_large = empty_path .. 'particles/bloodsplatters/bloodsplatter_freeze_$[1-3].xml',
			}, function ( comp )
				local blood = ComponentGetValue2( comp, 'blood_multiplier' )

				ComponentSetValue2( comp, 'blood_multiplier', blood * 3 )
			end, nil )

			if ( get_globals_num( 'PERK_PICKED_EMPTY_PROTECTION_FREEZE_PICKUP_COUNT', 0 ) == 0 ) then
				perk_pickup( nil, who, 'EMPTY_PROTECTION_FREEZE', false, false, true )
			end
		end,
		func_remove = function ( who )
			set_comp_value( who, 'DamageModelComponent', nil, {
				blood_material = 'blood',
				blood_spray_material = 'blood',
				blood_sprite_directional = empty_path .. 'particles/bloodsplatters/bloodsplatter_directional_$[1-3].xml',
				blood_sprite_large = empty_path .. 'particles/bloodsplatters//bloodsplatter_$[1-3].xml',
			}, function ( comp )
				local blood = ComponentGetValue2( comp, 'blood_multiplier' )

				ComponentSetValue2( comp, 'blood_multiplier', blood / 3 )
			end, nil )
		end,
	},
	{
		info = 'lava_blood',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		func = function( perk_item, who, item_name )
			set_comp_value( who, 'DamageModelComponent', nil, {
				blood_material = 'lava',
				blood_spray_material = 'lava',
				blood_sprite_directional = empty_path .. 'particles/bloodsplatters/bloodsplatter_directional_lava_$[1-3].xml',
				blood_sprite_large = empty_path .. 'particles/bloodsplatters/bloodsplatter_lava_$[1-3].xml',
			}, function ( comp )
				local blood = ComponentGetValue2( comp, 'blood_multiplier' )

				ComponentSetValue2( comp, 'blood_multiplier', blood * 3 )
			end, nil )

			if ( get_globals_num( 'PERK_PICKED_EMPTY_PROTECTION_LAVA_PICKUP_COUNT', 0 ) == 0 ) then
				perk_pickup( nil, who, 'EMPTY_PROTECTION_LAVA', false, false, true )
			end
		end,
		func_remove = function ( who )
			set_comp_value( who, 'DamageModelComponent', nil, {
				blood_material = 'blood',
				blood_spray_material = 'blood',
				blood_sprite_directional = empty_path .. 'particles/bloodsplatters/bloodsplatter_directional_$[1-3].xml',
				blood_sprite_large = empty_path .. 'particles/bloodsplatters//bloodsplatter_$[1-3].xml',
			}, function ( comp )
				local blood = ComponentGetValue2( comp, 'blood_multiplier' )

				ComponentSetValue2( comp, 'blood_multiplier', blood / 3 )
			end, nil )
		end,
	},
	{
		info = 'acid_blood',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		func = function( perk_item, who, item_name )
			set_comp_value( who, 'DamageModelComponent', nil, {
				blood_material = 'acid',
				blood_spray_material = 'acid',
				blood_sprite_directional = empty_path .. 'particles/bloodsplatters/bloodsplatter_directional_acid_$[1-3].xml',
				blood_sprite_large = empty_path .. 'particles/bloodsplatters/bloodsplatter_acid_$[1-3].xml',
			}, function ( comp )
				local blood = ComponentGetValue2( comp, 'blood_multiplier' )

				ComponentSetValue2( comp, 'blood_multiplier', blood * 3 )
			end, nil )

			if ( get_globals_num( 'PERK_PICKED_EMPTY_PROTECTION_ACID_PICKUP_COUNT', 0 ) == 0 ) then
				perk_pickup( nil, who, 'EMPTY_PROTECTION_ACID', false, false, true )
			end
		end,
		func_remove = function ( who )
			set_comp_value( who, 'DamageModelComponent', nil, {
				blood_material = 'blood',
				blood_spray_material = 'blood',
				blood_sprite_directional = empty_path .. 'particles/bloodsplatters/bloodsplatter_directional_$[1-3].xml',
				blood_sprite_large = empty_path .. 'particles/bloodsplatters//bloodsplatter_$[1-3].xml',
			}, function ( comp )
				local blood = ComponentGetValue2( comp, 'blood_multiplier' )

				ComponentSetValue2( comp, 'blood_multiplier', blood / 3 )
			end, nil )
		end,
	},
	{
		info = 'polymorph_blood',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		func = function( perk_item, who, item_name )
			set_comp_value( who, 'DamageModelComponent', nil, {
				blood_material = 'magic_liquid_polymorph',
				blood_spray_material = 'magic_liquid_polymorph',
				blood_sprite_directional = empty_path .. 'particles/bloodsplatters/bloodsplatter_directional_polymorph_$[1-3].xml',
				blood_sprite_large = empty_path .. 'particles/bloodsplatters/bloodsplatter_polymorph_$[1-3].xml',
			}, function ( comp )
				local blood = ComponentGetValue2( comp, 'blood_multiplier' )

				ComponentSetValue2( comp, 'blood_multiplier', blood * 3 )
			end, nil )

			if ( get_globals_num( 'PERK_PICKED_EMPTY_PROTECTION_POLYMORPH_PICKUP_COUNT', 0 ) == 0 ) then
				perk_pickup( nil, who, 'EMPTY_PROTECTION_POLYMORPH', false, false, true )
			end
		end,
		func_remove = function ( who )
			set_comp_value( who, 'DamageModelComponent', nil, {
				blood_material = 'blood',
				blood_spray_material = 'blood',
				blood_sprite_directional = empty_path .. 'particles/bloodsplatters/bloodsplatter_directional_$[1-3].xml',
				blood_sprite_large = empty_path .. 'particles/bloodsplatters//bloodsplatter_$[1-3].xml',
			}, function ( comp )
				local blood = ComponentGetValue2( comp, 'blood_multiplier' )

				ComponentSetValue2( comp, 'blood_multiplier', blood / 3 )
			end, nil )
		end,
	},
	{
		info = 'protection_glue',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		func = function( perk_item, who, item_name )
			EntityAddTag( who, 'glue_NOT' )
		end,
		func_remove = function( who )
			EntityRemoveTag( who, 'glue_NOT' )
		end,
	},
	{
		info = 'protection_shock',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		func = function( perk_item, who, item_name )
			set_comp_obj_value( who, 'DamageModelComponent', nil, {
				{ 'damage_multipliers', 'physics_hit', 0 },
			}, nil, nil )
		end,
		func_remove = function( who )
			set_comp_obj_value( who, 'DamageModelComponent', nil, {
				{ 'damage_multipliers', 'physics_hit', 0 },
			}, nil, nil )
		end,
	},
	{
		info = 'protection_freeze',
		game_effect = 'PROTECTION_FREEZE',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		func = function( perk_item, who, item_name )
			local tar_mat = { 'blood_cold', 'blood_cold_vapour' }

			for mat_count = 1, #tar_mat do
				EntitySetDamageFromMaterial( who, tar_mat[ mat_count ], 0 )
			end
		end,
		func_remove = function( who )
			local tar_mat = { 'blood_cold', 'blood_cold_vapour' }
			local def_dmg = { 0.0009, 0.0006 }

			for mat_count = 1, #tar_mat do
				EntitySetDamageFromMaterial( who, tar_mat[ mat_count ], def_dmg[ mat_count ] )
			end
		end,
	},
	{
		info = 'protection_venomous_curse',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		func = function( perk_item, who, item_name )
			EntityAddTag( who, 'curse_NOT' )

			local mul = get_comp_obj_value( who, 'DamageModelComponent', nil, {
				{ 'damage_multipliers', 'curse', 1 },
			}, nil )

			set_comp_obj_value( who, 'DamageModelComponent', nil, {
				{ 'damage_multipliers', 'curse', mul / 2 },
			}, nil, nil )
		end,
		func_remove = function( who )
			EntityRemoveTag( who, 'curse_NOT' )

			local mul = get_comp_obj_value( who, 'DamageModelComponent', nil, {
				{ 'damage_multipliers', 'curse', 0.5 },
			}, nil )

			set_comp_obj_value( who, 'DamageModelComponent', nil, {
				{ 'damage_multipliers', 'curse', mul * 2 },
			}, nil, nil )
		end,
	},
	{
		info = 'protection_lava',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		func = function( perk_item, who, item_name )
			local tar_mat = { 'lava' }

			for mat_count = 1, #tar_mat do
				EntitySetDamageFromMaterial( who, tar_mat[ mat_count ], 0 )
			end
		end,
		func_remove = function( who )
			local tar_mat = { 'lava' }
			local def_dmg = { 0.003 }

			for mat_count = 1, #tar_mat do
				EntitySetDamageFromMaterial( who, tar_mat[ mat_count ], def_dmg[ mat_count ] )
			end
		end,
	},
	{
		info = 'protection_acid',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		func = function( perk_item, who, item_name )
			local tar_mat = { 'acid', 'ice_acid_static', 'ice_acid_glass' }

			for mat_count = 1, #tar_mat do
				EntitySetDamageFromMaterial( who, tar_mat[ mat_count ], 0 )
			end
		end,
		func_remove = function( who )
			local tar_mat = { 'acid', 'ice_acid_static', 'ice_acid_glass' }
			local def_dmg = { 0.005, 0.001, 0.001 }

			for mat_count = 1, #tar_mat do
				EntitySetDamageFromMaterial( who, tar_mat[ mat_count ], def_dmg[ mat_count ] )
			end
		end,
	},
	{
		info = 'protection_teleport',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		func = function( perk_item, who, item_name )
			EntityRemoveTag( who, 'teleportable' )
			EntityAddTag( who, 'teleportable_NOT' )
			EntityAddTag( who, 'no_swap' )

			add_comp_remove_dupli( who, 'LuaComponent', 'empty_protection_teleport', {
				_tags = 'protection_teleport',
				script_shot = empty_path .. 'scripts/perks/protection_teleport.lua',
			} )
		end,
		func_remove = function( who )
			EntityAddTag( who, 'teleportable' )
			EntityRemoveTag( who, 'teleportable_NOT' )
			EntityRemoveTag( who, 'no_swap' )

			remove_all_comp( who, 'LuaComponent', 'empty_protection_teleport' )
		end,
	},
	{
		info = 'protection_slice',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		func = function( perk_item, who, item_name )
			add_comp_remove_dupli( who, 'LuaComponent', 'empty_protection_slice', {
				_tags = 'protection_slice',
				script_shot = empty_path .. 'scripts/perks/protection_slice.lua',
			} )

			set_comp_obj_value( who, 'DamageModelComponent', nil, {
				{ 'damage_multipliers', 'slice', 0 },
			}, nil, nil )
		end,
		func_remove = function( who )
			remove_all_comp( who, 'LuaComponent', 'empty_protection_slice' )

			set_comp_obj_value( who, 'DamageModelComponent', nil, {
				{ 'damage_multipliers', 'slice', 1 },
			}, nil, nil )
		end,
	},
	{
		info = 'protection_poison',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		func = function( perk_item, who, item_name )
			EntityAddTag( who, 'empty_poison_immunity' )

			local tar_mat = { 'poison', 'rock_static_poison' }

			for mat_count = 1, #tar_mat do
				EntitySetDamageFromMaterial( who, tar_mat[ mat_count ], 0 )
			end

			set_comp_obj_value( who, 'DamageModelComponent', nil, {
				{ 'damage_multipliers', 'poison', 0 },
			}, nil, nil )
		end,
		func_remove = function( who )
			EntityRemoveTag( who, 'empty_poison_immunity' )

			local tar_mat = {'poison', 'rock_static_poison'}
			local def_dmg = { 0.001, 0.001 }

			for mat_count = 1, #tar_mat do
				EntitySetDamageFromMaterial( who, tar_mat[ mat_count ], def_dmg[ mat_count ] )
			end

			set_comp_obj_value( who, 'DamageModelComponent', nil, {
				{ 'damage_multipliers', 'poison', 0 },
			}, nil, nil )
		end,
	},
	{
		info = 'protection_plasma',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		func = function( perk_item, who, item_name )
			local tag = 'protection_plasma'

			add_comp_remove_dupli( who, 'LuaComponent', tag, {
				_tags = tag,
				script_damage_about_to_be_received = empty_path .. 'scripts/perks/protection_plasma.lua',
			}, nil )
		end,
		func_remove = function( who )
			local tag = 'protection_plasma'

			remove_all_comp( who, 'LuaComponent', tag, nil )
		end,
	},
	{
		info = 'protection_blindness',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		func = function( perk_item, who, item_name )
			EntityAddTag( who, 'empty_blindness_immunity' )
		end,
		func_remove = function( who )
			EntityRemoveTag( who, 'empty_blindness_immunity' )
		end,
	},
	{
		info = 'protection_neutralized',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		func = function( perk_item, who, item_name )
			EntityAddTag( who, 'empty_neutralized_immunity' )
		end,
		func_remove = function( who )
			EntityRemoveTag( who, 'empty_neutralized_immunity' )
		end,
	},
	{
		info = 'protection_twitchy',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		func = function( perk_item, who, item_name )
			EntityAddTag( who, 'empty_twitchy_immunity' )
		end,
		func_remove = function( who )
			EntityRemoveTag( who, 'empty_twitchy_immunity' )
		end,
	},
	{
		info = 'protection_hearty',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		func = function( perk_item, who, item_name )
			EntityAddTag( who, 'empty_hearty_immunity' )
		end,
		func_remove = function( who )
			EntityRemoveTag( who, 'empty_hearty_immunity' )
		end,
	},
	{
		info = 'protection_polymorph',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		func = function( perk_item, who, item_name )
			EntityAddTag( who, 'polymorphable_NOT' )
		end,
		func_remove = function( who )
			EntityRemoveTag( who, 'polymorphable_NOT' )
		end,
	},
	{
		info = 'protection_touch_magic',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		func = function( perk_item, who, item_name )
			EntityAddTag( who, 'touchmagic_immunity' )
		end,
		func_remove = function( who )
			EntityRemoveTag( who, 'touchmagic_immunity' )
		end,
	},
	{
		info = 'return',
		stackable = STACKABLE_YES,
		usable_by_enemies = true,
		func = function ( perk_item, who, item_name )
			local d_comps = EntityGetComponent( who, 'DamageModelComponent' )

			for _, d_comp in ipairs( d_comps or { } ) do
				for i, _ in ipairs( all_d_muls ) do
					ComponentObjectSetValue2( d_comp, 'damage_multipliers', _, 1 )
				end
			end
		end,
		func_remove = function ( who )
			local d_comps = EntityGetComponent( who, 'DamageModelComponent' )

			for _, d_comp in ipairs( d_comps or { } ) do
				for i, _ in ipairs( all_d_muls ) do
					ComponentObjectSetValue2( d_comp, 'damage_multipliers', _, 1 )
				end
			end
		end,
	},
	{
		info = 'borrowed_vulnerability',
		stackable = STACKABLE_YES,
		usable_by_enemies = true,
		func = function ( perk_item, who, item_name )
			local d_comps = EntityGetComponent( who, 'DamageModelComponent' )

			for _, d_comp in ipairs( d_comps or { } ) do
				for i, _ in ipairs( all_d_muls ) do
					local mul = tonumber( ComponentObjectGetValue2( d_comp, 'damage_multipliers', _ ) ) or 1.0
					ComponentObjectSetValue2( d_comp, 'damage_multipliers', _, mul * 1.25 )
				end
			end
		end,
		func_remove = function ( who )
			local d_comps = EntityGetComponent( who, 'DamageModelComponent' )

			for _, d_comp in ipairs( d_comps or { } ) do
				for i, _ in ipairs( all_d_muls ) do
					local mul = tonumber( ComponentObjectGetValue2( d_comp, 'damage_multipliers', _ ) ) or 1.0
					ComponentObjectSetValue2( d_comp, 'damage_multipliers', _, mul / 3.25 )
				end
			end
		end,
	},
	{
		info = 'stone_skin',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		func = function( perk_item, who, item_name )
			EntityAddTag( who, 'drillable' )

			local d_muls = {
				melee = 0.5,
				projectile = 0.5,
				explosion = 0.5,
				electricity = 0.25,
				fire = 0.25,
				drill = 3.25,
				slice = 0.5,
				ice = 3.25,
				physics_hit = 0.5,
				radioactive = 0.5,
				poison = 0.5,
				curse = 3.25,
				holy = 3.25,
			}

			d_comps_mul( who, '*', d_muls )
		end,
		func_remove = function( who )
			EntityRemoveTag( who, 'drillable' )

			local d_muls = {
				melee = 0.5,
				projectile = 0.5,
				explosion = 0.5,
				electricity = 0.25,
				fire = 0.25,
				drill = 3.25,
				slice = 0.5,
				ice = 3.25,
				physics_hit = 0.5,
				radioactive = 0.5,
				poison = 0.5,
				curse = 3.25,
				holy = 3.25,
			}

			d_comps_mul( who, '/', d_muls )
		end,
	},
	{
		info = 'radiance',
		stackable = STACKABLE_NO,
		usable_by_enemies = false,
		func = function( perk_item, who, item_name )
			local x, y = EntityGetTransform( who )

			EntityAddComponent( who, 'LuaComponent', {
				_tags = 'empty_radiance,perk_component',
				script_source_file = empty_path .. 'scripts/perks/radiance.lua',
				execute_every_n_frame = 60,
			} )

			local child_id = EntityLoad( empty_path .. 'entities/misc/perks/radiance.xml', x, y )

			EntityAddTag( child_id, 'perk_empty_radiance' )
			EntityAddChild( who, child_id )
		end,
		func_remove = function( who )
			local remove = 'empty_radiance'

			remove_all_comp( who, 'LuaComponent', remove )
			rem_del_all_child( who, remove )
		end,
	},
	{
		info = 'more_spell_inventory',
		stackable = STACKABLE_YES,
		stackable_maximum = 2,
		usable_by_enemies = false,
		func = function( perk_item, who, item_name )
			local inv = { }

			local inv_y = get_comp_value( who, 'Inventory2Component', nil, {
				{ 'full_inventory_slots_y' , 1 },
			}, nil )

			if ( not EntityHasTag( who, 'more_spell_inv_1' ) ) then
				EntityAddTag( who, 'more_spell_inv_1' )

				inv.full_inventory_slots_y = inv_y + 1
			else
				if ( not EntityHasTag( who, 'more_spell_inv_2' ) ) then
					EntityAddTag( who, 'more_spell_inv_2' )

					inv.full_inventory_slots_y = inv_y + 1
				else
					inv.full_inventory_slots_y = 1
					inv.full_inventory_slots_x = 1
				end
			end

			set_comp_value( who, 'Inventory2Component', nil, inv, nil, nil )
		end,
		func_remove = function( who )
			if ( EntityHasTag( who, 'more_spell_inv_2' ) ) then
				EntityRemoveTag( who, 'more_spell_inv_2' )
			end
			if ( EntityHasTag( who, 'more_spell_inv_1' ) ) then
				EntityRemoveTag( who, 'more_spell_inv_1' )
			end

			set_comp_value( who, 'Inventory2Component', nil, {
				full_inventory_slots_y = 1,
				full_inventory_slots_x = 16,
			}, nil, nil )
		end,
	},
	{
		info = 'percentage_off',
		stackable = STACKABLE_NO,
		usable_by_enemies = false,
		func = function( perk_item, who, item_name )
			add_comp_remove_dupli( who, 'LuaComponent', 'empty_percentage_off', {
				_tags='empty_percentage_off,perk_component',
				execute_every_n_frame='60',
				script_source_file=empty_path .. 'scripts/perks/percentage_off.lua',
			} )
 		end,
		func_remove = function( who )
			remove_all_comp( who, 'LuaComponent', 'empty_percentage_off' )
		end,
	},
	{
		info = 'sanctuary_shield',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		func = function( perk_item, who, item_name )
			EntityAddComponent2( who, 'LuaComponent', {
				_tags = 'empty_sanctuary_shield_tracker,perk_component',
				execute_every_n_frame = 1,
				script_source_file = empty_path .. 'scripts/perks/sanctuary_shield.lua',
			} )

			EntityAddComponent2( who, 'VariableStorageComponent', {
				_tags = 'empty_sanctuary_shield_data,perk_component',
				value_int = 0,
				value_string = '0',
			} )

			local x, y = EntityGetTransform( who )
			EntityAddComponent2( who, 'VariableStorageComponent', {
				_tags = 'empty_sanctuary_shield_position,perk_component',
				value_float = x or 0,
				value_string = tostring( y or 0 ),
			} )
		end,
		func_remove = function( who )
			local data_comp = EntityGetFirstComponent( who, 'VariableStorageComponent', 'empty_sanctuary_shield_data' )

			if ( data_comp ) then
				local shield_entity = tonumber( ComponentGetValue2( data_comp, 'value_string' ) ) or 0

				if ( is_alive( shield_entity ) ) then
					EntityKill( shield_entity )
				end
			end

			remove_all_comp( who, 'LuaComponent', 'empty_sanctuary_shield_tracker' )
			remove_all_comp( who, 'VariableStorageComponent', 'empty_sanctuary_shield_data' )
			remove_all_comp( who, 'VariableStorageComponent', 'empty_sanctuary_shield_position' )
		end,
	},
	{
		info = 'adjust',
		stackable = STACKABLE_YES,
		stackable_maximum = 3,
		usable_by_enemies = true,
		func = function( perk_item, who, item_name )
			local tag = 'adjust'

			if ( not EntityHasTag( who, tag ) ) then
				add_comp( who, 'VariableStorageComponent', {
					_tags = tag,
					value_int = 0,
					value_float = 1,
				} )

				add_comp( who, 'LuaComponent', {
					_tags = tag,
					script_source_file = empty_path .. 'scripts/perks/adjust_add_frame.lua',
					execute_every_n_frame = 0,
				} )

				add_comp( who, 'ShotEffectComponent', {
					_tags = tag,
					extra_modifier = 'adjust',
				} )

				local x, y = EntityGetTransform( who )

				local c1 = EntityLoad( empty_path .. 'entities/misc/perks/adjust_aim_1.xml', x, y )
				local c2 = EntityLoad( empty_path .. 'entities/misc/perks/adjust_aim_2.xml', x, y )

				EntityAddChild( who, c1 )
				EntityAddChild( who, c2 )

				EntityAddTag( who, tag )
			else
				local count, delta = get_comp_value( who, 'VariableStorageComponent', tag, {
					{ 'value_int', 0 },
					{ 'value_float', 1 },
				}, nil )

				set_comp_value( who, 'VariableStorageComponent', tag, {
					value_int = count,
					value_float = delta + 1,
				}, nil, nil )
			end
		end,
		func_remove = function( who )
			local tag = 'adjust'

			local frames, level = get_comp_value( who, 'VariableStorageComponent', tag, {
				{ 'value_int', 0 },
				{ 'value_float', 1 },
			}, nil )

			if ( level > 1 ) then
				set_comp_value( who, 'VariableStorageComponent', nil, {
					value_int = frames,
					value_float = level - 1,
				}, nil, nil )
			else
				remove_all_comp( who, nil, tag, nil )
				rem_del_all_child( who, tag, nil )
			end
		end,
	},
	{
		info = 'hearts_also_heal',
		stackable = STACKABLE_NO,
		usable_by_enemies = false,
		func = function( perk_item, who, item_name )
			GlobalsSetValue( 'EMPTY_HEARTS_ALSO_HEAL', '1' )
		end,
		func_remove = function( who )
			GlobalsSetValue( 'EMPTY_HEARTS_ALSO_HEAL', '0' )
		end,
	},
	{
		info = 'health_regeneration',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		func = function( perk_item, who, item_name )
			local tag = 'empty_health_regeneration'

			add_comp_remove_dupli( who, 'LuaComponent', tag, {
				_tags = tag,
				execute_every_n_frame = 1800,
				script_source_file = empty_path .. 'scripts/perks/health_regeneration.lua',
			} )
		end,
		func_remove = function( who )
			remove_all_comp( who, 'LuaComponent', 'empty_health_regeneration' )
		end,
	},--[[
	{
		info = 'red_reset',
		stackable = STACKABLE_YES,
		usable_by_enemies = false,
		func = function( perk_item, who, item_name )
			local x = tonumber( MagicNumbersGetValue( 'DESIGN_PLAYER_START_POS_X' ) ) or 227
			local y = tonumber( MagicNumbersGetValue( 'DESIGN_PLAYER_START_POS_Y' ) ) or -85

			tp( who, x, y )

			--TODO
		end,
	},
	{
		info = 'dewborne_breeze',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		func = function ( perk_item, who, item_name )
			--
		end,
		func_remove = function ( who )
			--
		end,
	},
	{
		info = 'flesh_and_flame',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		func = function ( perk_item, who, item_name )
			--
		end,
		func_remove = function ( who )
			--
		end,
	},
	{
		info = 'random_neurotic_wand',
		stackable = STACKABLE_YES,
		usable_by_enemies = false,
		func = function ( perk_item, who, item_name )
			local x, y = EntityGetTransform( who )

			local wand = generate_neurotic_gun( nil, 10 )
		end,
		func_remove = function ( who )
			--
		end,
	},]]--
--[[
	{
		info = 'curse_illiterate',
		stackable = STACKABLE_NO,
		usable_by_enemies = false,
		not_in_default = true,
		func = function( perk_item, who, item_name ) --[[
			EntityAddTag( who, 'empty_curse_illiterate' )

			EntityAddComponent2( who, 'LuaComponent',
				{
					_tags = 'empty_curse_illiterate,perk_component',
					execute_every_n_frame = 15,
					script_source_file = empty_path .. 'scripts/perks/curse/curse_illiterate.lua',
				}
			)
			local content_need_obfuscate = backup_common_csv( )
			obfuscate_common_csv( content_need_obfuscate )
		end,
		func_remove = function( who ) --[[
			EntityRemoveTag( who, 'empty_curse_illiterate' )

			local tags_to_remove = {
				'empty_curse_illiterate',
			}

			for i, tag in ipairs( tags_to_remove ) do
				local comp = EntityGetComponentIncludingDisabled( who, 'LuaComponent', tag )
				for _, each in ipairs( comp or {} ) do
					EntityRemoveComponent( who, each )
				end
			end
			reset_common_csv( )
		end,
	},]]--
	{
		info = 'curse_monk',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		not_in_default_perk_pool = true,
		func = function( perk_item, who, item_name )
			local d_muls = {
				melee = 0.5,
				projectile = 0.5,
				explosion = 0.5,
				fire = 0.5,
				electricity = 0.5,
				drill = 0.5,
				slice = 0.5,
				ice = 0.5,
				physics_hit = 0.5,
				radioactive = 0.75,
				poison = 0.75,
				curse = 1.0,
				holy = 0.25,
				healing = 2.0,
			}

			if ( is_player( who ) ) then
				GlobalsSetValue( 'EMPTY_CURSE_MONK', '1' )

				if ( GlobalsGetValue( 'EMPTY_CURSE_GUARANTEED_LOSE', '0' ) == '1' ) then
					d_muls.curse = 0.5 * d_muls.curse
				end

				add_comp_remove_dupli( who, 'LuaComponent', 'empty_curse_monk', {
					_tags = 'empty_curse_monk,perk_component',
					execute_every_n_frame = 60,
					script_source_file = empty_path .. 'scripts/perks/curse/curse_monk.lua',
				} )

				if ( get_globals_num( 'PERK_PICKED_GOLD_IS_FOREVER_PICKUP_COUNT', 0 ) == 0 ) then
					perk_pickup( nil, who, 'GOLD_IS_FOREVER', false, false, true )
				end

				for _ = 1, 5 do
					perk_pickup( nil, who, 'ATTRACT_ITEMS', false, false, true )
				end

				if ( get_globals_num( 'PERK_PICKED_EMPTY_PERCENTAGE_OFF_PICKUP_COUNT', 0 ) == 0 ) then
					perk_pickup( nil, who, 'EMPTY_PERCENTAGE_OFF', false, false, true )
				end
			end

			d_comps_mul( who, '*', d_muls )
		end,
		func_remove = function( who )
			local d_muls = {
				melee = 0.5,
				projectile = 0.5,
				explosion = 0.5,
				fire = 0.5,
				electricity = 0.5,
				drill = 0.5,
				slice = 0.5,
				ice = 0.5,
				physics_hit = 0.5,
				radioactive = 0.75,
				poison = 0.75,
				curse = 1.0,
				holy = 0.25,
				healing = 2.0,
			}

			if ( is_player( who ) ) then
				GlobalsSetValue( 'EMPTY_CURSE_MONK', '0' )

				if ( GlobalsGetValue( 'EMPTY_CURSE_GUARANTEED_LOSE', '0' ) == '1' ) then
					d_muls.curse = 0.5 * d_muls.curse
				end

				remove_all_comp( who, 'LuaComponent', 'empty_curse_monk' )
				remove_all_comp( who, 'VariableStorageComponent', 'empty_curse_monk' )
			end

			d_comps_mul( who, '/', d_muls )
		end,
	},
	{
		info = 'curse_always_shuffle',
		stackable = STACKABLE_NO,
		usable_by_enemies = false,
		not_in_default_perk_pool = true,
		func = function( perk_item, who, item_name )
			GlobalsSetValue( 'EMPTY_CURSE_ALWAYS_SHUFFLE', '1' )

			local wands = EntityGetWithTag( 'wand' )

			for _, wand in ipairs( wands ) do
				local fire_rate, relaod = get_comp_obj_value( wand, 'AbilityComponent', nil, {
					{ 'gunaction_config', 'fire_rate_wait', 0 },
					{ 'gun_config', 'reload_time', 0 },
				} )

				if ( fire_rate > 0 ) then
					fire_rate = fire_rate / 2
				else
					fire_rate = fire_rate * 2
				end
				if ( relaod > 0 ) then
					relaod = relaod / 2
				else
					relaod = relaod * 2
				end

				set_comp_obj_value( wand, 'AbilityComponent', nil, {
					{ 'gun_config', 'shuffle_deck_when_empty', true },
					{ 'gunaction_config', 'fire_rate_wait', fire_rate },
					{ 'gun_config', 'reload_time', relaod },
				}, nil, nil )
			end
		end,
		func_remove = function( who )
			GlobalsSetValue( 'EMPTY_CURSE_ALWAYS_SHUFFLE', '0' )
		end,
	},
	{
		info = 'curse_short_wand',
		stackable = STACKABLE_NO,
		usable_by_enemies = false,
		not_in_default_perk_pool = true,
		func = function( perk_item, who, item_name )
			GlobalsSetValue( 'EMPTY_CURSE_SHORT_WAND', '1' )

			local wands = EntityGetWithTag( 'wand' )

			for _, wand in ipairs( wands ) do
				local mana_charge, mana_max = get_comp_value( wand, 'AbilityComponent', nil, {
					{ 'mana_charge_speed', 0 },
					{ 'mana_max', 0 },
				}, nil )

				set_comp_value( wand, 'AbilityComponent', nil, {
					mana_charge_speed = 1.2 * mana_charge,
					mana_max = 1.2 * mana_max,
				}, nil, nil )

				local real_cap = EntityGetWandCapacity( wand )

				real_cap = mod_cap( real_cap, 1, 7 )

				adjust_wand_deck( wand, {
					real_set = math.max( math.floor( real_cap ), 1 ),
				} )
			end
		end,
		func_remove = function( who )
			GlobalsSetValue( 'EMPTY_CURSE_SHORT_WAND', '0' )
		end,
	},
	{
		info = 'curse_malice_washes_over',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		not_in_default_perk_pool = true,
		func = function( perk_item, who, item_name )
			local curse = 'CURSE_MALICE_WASHES_OVER'

			if ( is_player( who ) ) then
				local players = get_all_players( )

				for _, player in ipairs( players ) do
					if ( EntityGetIsAlive( player ) ) then
						local x, y = EntityGetTransform( player )

						add_comp_remove_dupli( player, 'VariableStorageComponent', curse, {
							_tags = curse,
							value_float = x,
							value_string = tostring( y ),
						} )

						add_comp_remove_dupli( player, 'LuaComponent', curse, {
							_tags = curse,
							script_source_file = empty_path .. 'scripts/perks/curse/curse_malice_washes_over_delay.lua',
							execute_every_n_frame = 300,
							remove_after_executed = true,
						} )
					end
				end
			else
				local x, y = EntityGetTransform( who )

				add_comp_remove_dupli( who, 'VariableStorageComponent', curse, {
					_tags = curse,
					value_float = x,
					value_string = tostring( y ),
				} )

				add_comp_remove_dupli( who, 'LuaComponent', curse, {
					_tags = curse,
					script_source_file = empty_path .. 'scripts/perks/curse/curse_malice_washes_over_delay.lua',
					execute_every_n_frame = 180,
					remove_after_executed = true,
				} )
			end
		end,
		func_remove = function( who )
			local curse = 'CURSE_MALICE_WASHES_OVER'

			remove_all_comp( who, 'VariableStorageComponent', curse )
			remove_all_comp( who, 'LuaComponent', curse )

			rem_del_all_child( who, curse )
		end,
	},
	{
		info = 'curse_reality_shift',
		stackable = STACKABLE_YES,
		usable_by_enemies = false,
		not_in_default_perk_pool = true,
		func = function( perk_item, who, item_name )
			local x, y = EntityGetTransform( who )
			local a, b, c = time_for_vec3( )

			fungal_shift( who, x + a + c, y + b + c, true )
			fungal_shift( who, x + a + c, y + b - c, true )
			fungal_shift( who, x + a - c, y + b - c, true )
			fungal_shift( who, x + a + c, y - b - c, true )
			fungal_shift( who, x + a - c, y - b - c, true )
			fungal_shift( who, x - a - c, y - b - c, true )
			fungal_shift( who, x - a - c, y - b + c, true )
			fungal_shift( who, x - a - c, y + b + c, true )
			fungal_shift( who, x - a + c, y - b + c, true )
			fungal_shift( who, x - a + c, y + b + c, true )

			for _ = 1, 2 do
				perk_pickup( nil, who, 'EMPTY_FUNGAL_SHIFT_ADD_CAPACITY', false, false, true )
			end
		end,
	},
	{
		info = 'curse_guaranteed_lose',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		not_in_default_perk_pool = true,
		func = function( perk_item, who, item_name )
			local d_muls = {
				melee = 4.0,
				projectile = 4.0,
				explosion = 4.0,
				fire = 4.0,
				electricity = 4.0,
				drill = 4.0,
				slice = 4.0,
				ice = 4.0,
				physics_hit = 4.0,
				radioactive = 4.0,
				poison = 4.0,
				curse = 3.0,
				holy = 2.0,
				healing = 4.0,
			}

			if ( is_player( who ) ) then
				GlobalsSetValue( 'EMPTY_CURSE_GUARANTEED_LOSE', '1' )

				if ( GlobalsGetValue( 'EMPTY_CURSE_MONK', '0' ) == '1' ) then
					d_muls.curse = 0.5 * d_muls.curse
				end

				max_hp_mul( who, '*', 2, true )

				local x, y = EntityGetTransform( who )

				for _ = 1, 4, 1 do
					EntityLoad( empty_path .. 'entities/items/pickup/potion_healthium_many_hp.xml', x + loc_center_fix( 4, 4, _ ), y )
				end
			end

			d_comps_mul( who, '*', d_muls )
		end,
		func_remove = function( who )
			local d_muls = {
				melee = 4.0,
				projectile = 4.0,
				explosion = 4.0,
				fire = 4.0,
				electricity = 4.0,
				drill = 4.0,
				slice = 4.0,
				ice = 4.0,
				physics_hit = 4.0,
				radioactive = 4.0,
				poison = 4.0,
				curse = 3.0,
				holy = 2.0,
				healing = 4.0,
			}

			if ( is_player( who ) ) then
				GlobalsSetValue( 'EMPTY_CURSE_GUARANTEED_LOSE', '0' )

				if ( GlobalsGetValue( 'EMPTY_CURSE_MONK', '0' ) == '1' ) then
					d_muls.curse = 0.5 * d_muls.curse
				end
			end

			d_comps_mul( who, '/', d_muls )
		end,
	},
	{
		info = 'curse_gravity_free',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		not_in_default_perk_pool = true,
		func = function ( perk_item, who, item_name )
			if ( is_player( who ) ) then
				GlobalsSetValue( 'EMPTY_CURSE_GRAVITY_FREE', '1' )
			end

			set_comp_value( who, 'CharacterPlatformingComponent', nil, {
				pixel_gravity = 0,
				run_velocity = 0,
				jump_velocity_x = 0,
				fly_speed_max_up = 0,
				fly_speed_max_down = 0,
				fly_velocity_x = 0,
			}, nil, nil )

			if ( is_player( who ) ) then
				local x, y = EntityGetTransform( who )

				CreateItemActionEntity( 'HOOK', x, y )

				local e = EntityLoad( 'data/entities/buildings/workshop_tree_holiday.xml', x, y )

				add_comp_remove_dupli( e, 'LifetimeComponent', nil, {
					lifetime = 3600,
				} )
			end
		end,
		func_remove = function ( who )
			if ( is_player( who ) ) then
				GlobalsSetValue( 'EMPTY_CURSE_GRAVITY_FREE', '0' )
			end

			set_comp_value( who, 'CharacterPlatformingComponent', nil, {
				pixel_gravity = 350,
				run_velocity = 57,
				jump_velocity_x = 56,
				fly_speed_max_up = 95,
				fly_speed_max_down = 85,
				fly_velocity_x = 52,
			}, nil, nil )
		end,
	},
	{
		info = 'curse_death_trail',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		not_in_default_perk_pool = true,
		func = function ( perk_item, who, item_name )
			local curse = 'CURSE_DEATH_TRAIL'

			add_comp_remove_dupli( who, 'LuaComponent', curse, {
				_tags = curse,
				script_source_file = empty_path .. 'scripts/perks/curse/curse_death_trail.lua',
				execute_every_n_frame = 0,
				remove_after_executed = true,
			} )

			add_comp_remove_dupli( who, 'LuaComponent', curse, {
				_tags = curse,
				script_source_file = empty_path .. 'scripts/perks/curse/curse_death_trail.lua',
				execute_every_n_frame = 2,
			} )

			local c_comp = EntityGetFirstComponent( who, 'CharacterPlatformingComponent' )

			if ( c_comp ~= nil ) then
				local values = {
					pixel_gravity = ComponentGetValue2( c_comp, 'pixel_gravity' ),
					run_velocity = ComponentGetValue2( c_comp, 'run_velocity' ),
					fly_velocity_x = ComponentGetValue2( c_comp, 'fly_velocity_x' ),
				}

				set_comp_value( who, 'CharacterPlatformingComponent', nil, {
					pixel_gravity = values.pixel_gravity / 1.2,
					run_velocity = values.run_velocity * 1.2,
					fly_velocity_x = values.fly_velocity_x * 1.2,
				}, nil, nil )
			end
		end,
		func_remove = function ( who )
			local curse = 'CURSE_DEATH_TRAIL'

			remove_all_comp( who, 'LuaComponent', curse )
			remove_all_comp( who, 'VariableStorageComponent', curse )

			local c_comp = EntityGetFirstComponent( who, 'CharacterPlatformingComponent' )

			if ( c_comp ~= nil ) then
				local values = {
					pixel_gravity = ComponentGetValue2( c_comp, 'pixel_gravity' ),
					run_velocity = ComponentGetValue2( c_comp, 'run_velocity' ),
					fly_velocity_x = ComponentGetValue2( c_comp, 'fly_velocity_x' ),
				}

				set_comp_value( who, 'CharacterPlatformingComponent', nil, {
					pixel_gravity = values.pixel_gravity * 1.2,
					run_velocity = values.run_velocity / 1.2,
					fly_velocity_x = values.fly_velocity_x / 1.2,
				}, nil, nil )
			end
		end,
	},--[[
	{
		info = 'curse_furious_cocktail',
		stackable = STACKABLE_NO,
		usable_by_enemies = true,
		not_in_default_perk_pool = true,
		func = function ( perk_item, who, item_name )
			add_comp_remove_dupli( who, 'LuaComponent', 'CURSE_FURIOUS_COCKTAIL', {
				_tags = 'CURSE_FURIOUS_COCKTAIL',
				script_source_file = empty_path .. 'scripts/perks/curse/curse_furious_cocktail.lua',
				execute_every_n_frame = 540,
			} )
		end,
		func_remove = function ( who )
			remove_all_comp( who, 'LuaComponent', 'CURSE_FURIOUS_COCKTAIL' )
		end,
	},]]--
}

local changed_perks = {--[[
	{
		id = 'BREATH_UNDERWATER',
		func = function( entity_perk_item, who, item_name )
			local swim = { }

			swim.swim_idle, swim.swim_up, swim.swim_down, swim.swim_drag, swim.swim_drag_extra =
			get_comp_info( who, 'CharacterPlatformingComponent', nil, {
				{ 'swim_idle_buoyancy_coeff', 1.2 },
				{ 'swim_up_buoyancy_coeff', 0.9 },
				{ 'swim_down_buoyancy_coeff', 0.7 },
				{ 'swim_drag', 0.95 },
				{ 'swim_extra_horizontal_drag', 0.9 },
			}, nil )

			swim.swim_idle = swim.swim_idle * 0.6
			swim.swim_up = swim.swim_up * 0.2
			swim.swim_down = swim.swim_down * 0.2
			swim.swim_drag = swim.swim_drag * 1.2
			swim.swim_drag_extra = swim.swim_drag_extra * 1.2

			set_comp_value( who, 'CharacterPlatformingComponent', nil, swim, nil, nil )
		end,
		func_remove = function( who )
			local swim = { }

			swim.swim_idle, swim.swim_up, swim.swim_down, swim.swim_drag, swim.swim_drag_extra =
			get_comp_info( who, 'CharacterPlatformingComponent', nil, {
				{ 'swim_idle_buoyancy_coeff', 1.2 },
				{ 'swim_up_buoyancy_coeff', 0.9 },
				{ 'swim_down_buoyancy_coeff', 0.7 },
				{ 'swim_drag', 0.95 },
				{ 'swim_extra_horizontal_drag', 0.9 },
			}, nil )

			swim.swim_idle = swim.swim_idle / 0.6
			swim.swim_up = swim.swim_up / 0.2
			swim.swim_down = swim.swim_down / 0.2
			swim.swim_drag = swim.swim_drag / 1.2
			swim.swim_drag_extra = swim.swim_drag_extra / 1.2

			set_comp_value( who, 'CharacterPlatformingComponent', nil, swim, nil, nil )
		end,
	},]]--
	{
		id = 'GOLD_IS_FOREVER',
		func = function( entity_perk_item, who, item_name )
			local world = GameGetWorldStateEntity( )

			set_comp_value( world, 'WorldStateComponent', nil, {
				perk_gold_is_forever = true,
			}, nil, nil )
		end,
		func_remove = function( who )
			local world = GameGetWorldStateEntity( )

			set_comp_value( world, 'WorldStateComponent', nil, {
				perk_gold_is_forever = false,
			}, nil, nil )
		end,
	},--[[
	{
		id = '',
		func = function( entity_perk_item, who, item_name )
		end,
		func_remove = function( who )
		end,
	},]]--
	{
		id = 'VAMPIRISM',
		func = function( entity_perk_item, who, item_name )
			add_halo_level( who, -1 )
		end,
	},
	{
		id = "PROTECTION_FIRE",
		func = function( entity_perk_item, who, item_name )
			set_comp_obj_value( who, 'DamageModelComponent', nil, {
				{ 'damage_multipliers', 'fire', 0 },
			}, nil, nil )
		end,
		func_remove = function( entity_perk_item, who, item_name )
			set_comp_obj_value( who, 'DamageModelComponent', nil, {
				{ 'damage_multipliers', 'fire', 1 },
			}, nil, nil )
		end,
	},
	{
		id = "PROTECTION_RADIOACTIVITY",
		func = function( entity_perk_item, who, item_name )
			set_comp_obj_value( who, 'DamageModelComponent', nil, {
				{ 'damage_multipliers', 'radioactive', 0 },
			}, nil, nil )
		end,
		func_remove = function( entity_perk_item, who, item_name )
			set_comp_obj_value( who, 'DamageModelComponent', nil, {
				{ 'damage_multipliers', 'radioactive', 1 },
			}, nil, nil )
		end,
	},
	{
		id = "PROTECTION_EXPLOSION",
		func = function( entity_perk_item, who, item_name )
			set_comp_obj_value( who, 'DamageModelComponent', nil, {
				{ 'damage_multipliers', 'explosion', 0 },
			}, nil, nil )
		end,
		func_remove = function( entity_perk_item, who, item_name )
			set_comp_obj_value( who, 'DamageModelComponent', nil, {
				{ 'damage_multipliers', 'explosion', 1 },
			}, nil, nil )
		end,
	},
	{
		id = "PROTECTION_MELEE",
		func = function( entity_perk_item, who, item_name )
			set_comp_obj_value( who, 'DamageModelComponent', nil, {
				{ 'damage_multipliers', 'melee', 0 },
			}, nil, nil )
		end,
		func_remove = function( entity_perk_item, who, item_name )
			set_comp_obj_value( who, 'DamageModelComponent', nil, {
				{ 'damage_multipliers', 'melee', 1 },
			}, nil, nil )
		end,
	},
	{
		id = "PROTECTION_ELECTRICITY",
		func = function( entity_perk_item, who, item_name )
			set_comp_obj_value( who, 'DamageModelComponent', nil, {
				{ 'damage_multipliers', 'electricity', 0 },
			}, nil, nil )
		end,
		func_remove = function( entity_perk_item, who, item_name )
			set_comp_obj_value( who, 'DamageModelComponent', nil, {
				{ 'damage_multipliers', 'electricity', 1 },
			}, nil, nil )
		end,
	},
}

for i, _ in ipairs( new_perks ) do
	if ( is_not_nil_str( _.info ) ) then
		local info = string.lower( _.info )
		local e_info = 'empty_' .. info

		_.id				= string.upper( e_info )
		_.ui_name			= '$perk_' .. e_info
		_.ui_description	= '$perkdesc_' .. e_info
		_.ui_icon			= ui_icon_url .. info .. '.png'
		_.perk_icon			= perk_icon_url .. info .. '.png'
		_.info				= nil
	end
end

update_table_by_id( perk_list, changed_perks, true )
add_table( perk_list, new_perks, false, false )

function get_perk_act_count( entity, perk_name )
	local count = 0

	for i, child in ipairs( get_all_child( entity ) ) do
		if ( is_has_comp( child, 'UIIconComponent', nil, perk_name ) ) then
			count = count + 1
		end
	end

	return count
end

function undo_perk_pickup( style )
	local flag = string.upper( style ) .. '_PERK_TOTAL_COUNT'
	local count = get_globals_num( flag, 0 )

	GlobalsSetValue( flag, tostring( count - 1 ) )
end

function apply_last_bleed( entity, perk_entity )
	local act_perks = get_act_perks( )
end
--[[]]--