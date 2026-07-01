dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

---<<<<<<<<<<<<<<<<<<<<<<<< 测试用代码 >>>>>>>>>>>>>>>>>>>>>>>>---

-- nothing here

---<<<<<<<<<<<<<<<<<<<<<<<< 翻译文件 >>>>>>>>>>>>>>>>>>>>>>>>---

local trans = ModTextFileGetContent( 'data/translations/common.csv' )
local add_str = ''

if ( trans: sub( -1 ) == '\n' ) then
	add_str = ModTextFileGetContent( empty_path .. 'translations/empty_translation.csv' )
else
	add_str = '\n' .. ModTextFileGetContent( empty_path .. 'translations/empty_translation.csv' )
end

-- 追加翻译: 伊芙琳娜
if ( get_setting_by_def( 'SVAROG_TRANSLATION' ) ) then
	add_str = add_str .. '\n' .. ModTextFileGetContent( empty_path .. 'translations/svarog_translation.csv' )
end

if ( add_str ~= '' ) then
	trans = trans .. add_str
end

ModTextFileSetContent( 'data/translations/common.csv', trans )

---<<<<<<<<<<<<<<<<<<<<<<<< 通用魔数设置 >>>>>>>>>>>>>>>>>>>>>>>>---

local magics = {
	-- 世界设置
	'CHAOS_CONNECTED_WORLD',

	-- 敌怪设置
	'NO_KUMMITUS',

	-- 视觉设置
	'REMOVE_LOW_HP_FLASH',
	'VISION_IMPROVE',

	-- 漏洞 & 轮椅设置
	'BUGFIX_HAND_OF_MASTER',
}

for _, magic in ipairs( magics ) do
	if ( get_setting_by_def( magic ) ) then
		ModMagicNumbersFileAdd( empty_path .. 'magic_numbers/' .. string.lower( magic ) .. '.xml' )
	end
end

---<<<<<<<<<<<<<<<<<<<<<<<< 通用 lua 覆写 >>>>>>>>>>>>>>>>>>>>>>>>---

local overwrites = { }

-- 新内容设置
if ( get_setting_by_def( 'EFFECT_CHANGE_INIT_WAND_BLUE' ) ) then
	table.insert( overwrites, 'scripts/gun/procedural/starting_wand.lua' )
end

if ( get_setting_by_def( 'EFFECT_CHANGE_INIT_WAND_RED' ) ) then
	table.insert( overwrites, 'scripts/gun/procedural/starting_bomb_wand.lua' )
end

if ( get_setting_by_def( 'EFFECT_CHANGE_CHEST_LIGHT' ) ) then
	table.insert( overwrites, 'scripts/buildings/chest_light.lua' )
end

if ( get_setting_by_def( 'EFFECT_CHANGE_CHEST_DARK' ) ) then
	table.insert( overwrites, 'scripts/buildings/chest_dark.lua' )
end

if ( get_setting_by_def( 'LOOT_CHANGE_ALCHEMIST' ) ) then
	table.insert( overwrites, 'entities/animals/boss_alchemist/death.lua' )
end

if ( get_setting_by_def( 'LOOT_CHANGE_WIZARD' ) ) then
	table.insert( overwrites, 'entities/animals/boss_wizard/death.lua' )
end

if ( get_setting_by_def( 'LOOT_CHANGE_FRIEND' ) ) then
	table.insert( overwrites, {
		source = 'scripts/animals/friend_death.lua',
		replace = 'entities/animals/boss_friend/death.lua',
	} )
end

if ( get_setting_by_def( 'EFFECT_CHANGE_POTION_VOLUME' ) ) then
	add_table( overwrites, {
		'scripts/items/potion.lua',
		'scripts/items/potion_random_material.lua'
	} )
else
	if ( get_setting_by_def( 'EFFECT_CHANGE_POTION_CONTENT' ) ) then
		table.insert( overwrites, 'scripts/items/potion.lua' )
	end
end

if ( get_setting_by_def( 'EFFECT_CHANGE_TEMPLE_HEART_ALSO_BUFF' ) ) then
	add_table( overwrites, {
		'scripts/items/heart.lua',
		'scripts/items/heart_better.lua',
		'scripts/items/heart_evil.lua',
		'scripts/items/heart_fullhp_temple.lua',
	} )
end

-- 世界设置
if ( get_setting_by_def( 'EASY_NG_PLUS' )
	or get_setting_by_def( 'CHAOS_CONNECTED_WORLD' ) ) then
	table.insert( overwrites, 'scripts/newgame_plus.lua' )
end

-- 视觉设置
if ( get_setting_by_def( 'VISION_IMPROVE' ) ) then
	add_table( overwrites, {
		'shaders/post_final.frag',
		'shaders/post_final.vert',
	} )
end

-- 漏洞 & 轮椅设置
if ( get_setting_by_def( 'BUGFIX_SPELL_TO_POWER' ) ) then
	table.insert( overwrites, 'scripts/projectiles/spells_to_power.lua' )
end

if ( get_setting_by_def( 'BUGFIX_DUPE_MAX_HP_FROM_HEARTY' ) ) then
	add_table( overwrites, {
		'scripts/status_effects/hearty_start.lua',
		'scripts/status_effects/hearty_end.lua',
	} )
else
	add_table( overwrites, {
		{
			source = 'scripts/status_effects/hearty_start.lua',
			replace = 'scripts/status_effects/hearty_start_full_restore.lua',
		},
		{
			source = 'scripts/status_effects/hearty_end.lua',
			replace = 'scripts/status_effects/hearty_end_full_restore.lua',
		},
	} )
end

if ( get_setting_by_def( 'BUGFIX_DUPE_DMG_MULTI_FROM_VULNERABLE' ) ) then
	add_table( overwrites, {
		'scripts/status_effects/wither_start.lua',
		'scripts/status_effects/wither_end.lua',
	} )
end

if ( get_setting_by_def( 'BUGFIX_CONNOISSEUR_OF_WANDS' ) ) then
	table.insert( overwrites, 'entities/animals/boss_pit/boss_pit_logic.lua' )
end

for i, _ in ipairs( overwrites ) do
	if ( type( _ ) == 'string' ) then
		ModTextFileSetContent( 'data/' .. _, ModTextFileGetContent( empty_path .. _ ) )
	elseif ( type( _ ) == 'table' ) then
		ModTextFileSetContent( 'data/' .. _.source, ModTextFileGetContent( empty_path .. _.replace ) )
	end
end

---<<<<<<<<<<<<<<<<<<<<<<<< 通用群系追加 >>>>>>>>>>>>>>>>>>>>>>>>---

local biomes = {
	'alchemist_secret',
	'boss_arena', 'boss_arena_top', 'boss_limbs_arena',
	'clouds',
	'coalmine', 'coalmine_alt',
	'crypt', 'desert',
	'endgame', 'endgame_end',
	'excavationsite',
	'fungicave', 'fungiforest', 'liquidcave',
	'meat',
	'pyramid', 'pyramid_hallway',
	'rainforest', 'rainforest_dark',
	'robobase', 'robot_egg',
	'sandcave', 'sandroom',
	'secret_altar', 'secret_entrance',
	'smokecave_left', 'smokecave_middle', 'smokecave_right',
	'snowcastle', 'snowcastle_hourglass_chamber',
	'the_end', 'tower',
	'vault', 'vault_frozen',
	'wandcave', 'watercave',
	'winter', 'wizardcave',
}

for i, _ in ipairs( biomes ) do
	ModLuaFileAppend( 'data/scripts/biomes/' .. _ .. '.lua', empty_path .. 'scripts/biomes/biome_append.lua' )
end

---<<<<<<<<<<<<<<<<<<<<<<<< 通用 lua 追加 >>>>>>>>>>>>>>>>>>>>>>>>---

local luas = {
	'scripts/biomes/mountain/mountain_hall',
	'scripts/biomes/mountain_tree',
	'scripts/biomes/the_end',
	'scripts/perks/perk_list',
	'scripts/gun/gun',
	'scripts/gun/gun_actions',
	'scripts/gun/gun_extra_modifiers',
	'scripts/status_effects/status_list',
}

if ( get_setting_by_def( 'EFFECT_CHANGE_WAND_CONTENT' ) ) then
	add_table( luas, {
		'scripts/gun/procedural/gun_procedural',
		'scripts/gun/procedural/gun_procedural_better',
	} )
end

for i, _ in ipairs( luas ) do
	ModLuaFileAppend( 'data/' .. _ .. '.lua', empty_path .. _ .. '.lua' )
end

---<<<<<<<<<<<<<<<<<<<<<<<< 开局更改 >>>>>>>>>>>>>>>>>>>>>>>>---

dofile_once( 'data/scripts/perks/perk.lua' )
dofile_once( 'data/scripts/perks/perk_utilities.lua' )

-- function OnMagicNumbersAndWorldSeedInitialized( )
-- 	local perks_info = ''
--
-- 	for i, _ in ipairs( perk_list ) do
-- 		perks_info = perks_info .. ( [[["%s"] = "%s",%s]] ) : format( _.ui_name, _.id, '\n' )
-- 	end
--
-- 	perks_info = 'return {\n' .. perks_info .. '}'
--
-- 	ModTextFileSetContent( empty_path .. '_virtual/perks_info.lua', perks_info )
-- end

function OnPlayerSpawned( player )
	local death = get_stat_value( 'death_count', 0 )

	if ( get_setting_by_def( 'DISPLAY_DEATH_COUNT' ) ) then
		imp_print( get_trans_text( '$empty_death_count', death ) )
	end

	if ( GlobalsGetValue( 'EMPTY_STARTING_CHANGE', '0' ) == '0' ) then
		GlobalsSetValue( 'EMPTY_STARTING_CHANGE', '1' )

		if ( get_setting_by_def( 'EFFECT_CHANGE_PLAYER_SPEED_CAP' ) ) then
			local plat = {
				{ 'run_velocity', 57 },
				{ 'jump_velocity_y', -95 },
				{ 'jump_velocity_x', 57 },
				{ 'fly_speed_max_up', 95 },
				{ 'fly_speed_max_down', 95 },
				{ 'fly_velocity_x', 57 },
				{ 'pixel_gravity', 350 },
				{ 'accel_x', 0.15 },
				{ 'accel_x_air', 0.15 },

				{ 'velocity_min_x', -int_huge },
				{ 'velocity_max_x', int_huge },
				{ 'velocity_min_y', -int_huge },
				{ 'velocity_max_y', int_huge },
			}

			set_comp_value( player, 'CharacterPlatformingComponent', nil, plat, nil, nil )
		end

		if ( get_setting_by_def( 'EFFECT_CHANGE_STONE_AFFECT_IN_INV' ) ) then
			add_comp( player, 'LuaComponent', {
				{ '_tags', 'empty_stone_aff_in_inv' },
				{ 'script_source_file', empty_path .. 'settings_lua/stone_affect_in_inv.lua' },
				{ 'execute_every_n_frame', 180 },
			}, nil )
		end

		if ( get_setting_by_def( 'EFFECT_CHANGE_POTION_HP' )
			or get_setting_by_def( 'EFFECT_CHANGE_POTION_HIGH_EXPLOSION' ) ) then
			add_comp( player, 'LuaComponent', {
				{ '_tags', 'empty_potion_change' },
				{ 'script_source_file', empty_path .. 'settings_lua/potion_change.lua' },
				{ 'execute_every_n_frame', 180 },
			}, nil )
		end

		local kick = {
			{ 'kick_radius', 4 },
		}

		set_comp_value( player, 'KickComponent', nil, kick, nil, nil )

		local p_sh = {
			{ 'camera_max_distance_from_character', 64 },
			{ 'eating_cells_per_frame', 3 },
		}

		set_comp_value( player, 'PlatformShooterPlayerComponent', nil, p_sh, nil, nil )

		for _, curse in ipairs( all_curses ) do
			if ( get_setting_by_def( curse ) ) then
				perk_pickup( nil, player, 'EMPTY_' .. curse, false, false, true )
			end
		end
	end
end

---<<<<<<<<<<<<<<<<<<<<<<<< 死亡效果 >>>>>>>>>>>>>>>>>>>>>>>>---

if ( get_setting_by_def( 'MAGNIFICENT_CONCLUSION' ) ) then
	function OnPlayerDied( player )
		local players = get_all_players( )

		-- 防止多人模式在有其余玩家存活时意外地触发死亡演出
		for i, _ in ipairs( players ) do
			if ( is_alive( _ ) ) then
				return
			end
		end

		local x, y = EntityGetTransform( player )

		EntityLoad( empty_path .. 'entities/projectiles/circle_death.xml', x, y )
	end
end

---<<<<<<<<<<<<<<<<<<<<<<<< 世界更新前 >>>>>>>>>>>>>>>>>>>>>>>>---

--function OnWorldPreUpdate( )
--	set_r_seed( )
--
--	-- if ( GlobalsGetValue( 'EMPTY_PERK_REMOVE_COUNT', '0' ) ~= '0' ) then
--	-- 	dofile( empty_path .. '' )
--	-- end
--end
