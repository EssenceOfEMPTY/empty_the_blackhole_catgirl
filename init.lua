dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

---<<<<<<<<<<<<<<<<<<<<<<<< 测试用代码 >>>>>>>>>>>>>>>>>>>>>>>>---

--

---<<<<<<<<<<<<<<<<<<<<<<<< 常规翻译 >>>>>>>>>>>>>>>>>>>>>>>>---

local translation = ModTextFileGetContent( 'data/translations/common.csv' )
local add_str = ''

if ( translation: sub( -1 ) == '\n' ) then
	add_str = ModTextFileGetContent( empty_path .. 'translations/empty_translation.csv' )
else
	add_str = '\n' .. ModTextFileGetContent( empty_path .. 'translations/empty_translation.csv' )
end

--追加翻译: 伊芙琳娜
if ( ModSettingGet( 'empty_the_blackhole_catgirl.SVAROG_TRANSLATION' ) ) then
	add_str = add_str .. '\n' .. ModTextFileGetContent( empty_path .. 'translations/svarog_translation.csv' )
end

if ( add_str ~= '' ) then
	translation = translation .. add_str
end

ModTextFileSetContent( 'data/translations/common.csv', translation )

---<<<<<<<<<<<<<<<<<<<<<<<< 通用魔数设置 >>>>>>>>>>>>>>>>>>>>>>>>---

local magics = {
	--世界设置
	'CHAOS_CONNECTED_WORLD',

	--敌怪设置
	'NO_KUMMITUS',

	--视觉设置
	'REMOVE_LOW_HP_FLASH',
	'VISION_IMPROVE',

	--漏洞 & 轮椅设置
	'BUGFIX_HAND_OF_MASTER',
}

for _, magic in ipairs( magics ) do
	local setting = ModSettingGet( 'empty_the_blackhole_catgirl.' .. magic )

	if ( setting or setting == nil ) then
		ModMagicNumbersFileAdd( empty_path .. 'magic_numbers/' .. string.lower( magic ) .. '.xml' )
	end
end

---<<<<<<<<<<<<<<<<<<<<<<<< 通用文件覆写 >>>>>>>>>>>>>>>>>>>>>>>>---

local overwrite = { }

--世界设置
if ( ModSettingGet( 'empty_the_blackhole_catgirl.EASY_NG+' )
	or ModSettingGet( 'empty_the_blackhole_catgirl.CHAOS_CONNECTED_WORLD' ) ) then
	table.insert( overwrite, 'scripts/newgame_plus.lua' )
end

--视觉设置
if ( ModSettingGet( 'empty_the_blackhole_catgirl.VISION_IMPROVE' ) ) then
	add_table( overwrite, {
		'shaders/post_final.frag',
		'shaders/post_final.vert',
	} )
end

--漏洞 & 轮椅设置
if ( ModSettingGet( 'empty_the_blackhole_catgirl.BUGFIX_SPELL_TO_POWER' ) ) then
	table.insert( overwrite, 'scripts/projectiles/spells_to_power.lua' )
end

if ( ModSettingGet( 'empty_the_blackhole_catgirl.BUGFIX_DUPE_MAX_HP_FROM_HEARTY' ) ) then
	add_table( overwrite, {
		'scripts/status_effects/hearty_start.lua',
		'scripts/status_effects/hearty_end.lua',
	} )
else
	add_table( overwrite, {
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

if ( ModSettingGet( 'empty_the_blackhole_catgirl.BUGFIX_DUPE_DMG_MULTI_FROM_VULNERABLE' ) ) then
	add_table( overwrite, {
		'scripts/status_effects/wither_start.lua',
		'scripts/status_effects/wither_end.lua',
	} )
end

if ( ModSettingGet( 'empty_the_blackhole_catgirl.BUGFIX_CONNOISSEUR_OF_WANDS' ) ) then
	table.insert( overwrite, 'entities/animals/boss_pit/boss_pit_logic.lua' )
end

for i, _ in ipairs( overwrite ) do
	if ( type( _ ) == 'string' ) then
		ModTextFileSetContent( 'data/' .. _, ModTextFileGetContent( empty_path .. _ ) )
	elseif ( type( _ ) == 'table' ) then
		ModTextFileSetContent( 'data/' .. _.source, ModTextFileGetContent( empty_path .. _.replace ) )
	end
end

---<<<<<<<<<<<<<<<<<<<<<<<< 通用群系追加 >>>>>>>>>>>>>>>>>>>>>>>>---

local biome_append = {
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

for i, _ in ipairs( biome_append ) do
	ModLuaFileAppend( 'data/scripts/biomes/' .. _ .. '.lua', empty_path .. 'scripts/biomes/biome_append.lua' )
end

---<<<<<<<<<<<<<<<<<<<<<<<< 通用 lua 追加 >>>>>>>>>>>>>>>>>>>>>>>>---

local lua_append = {
	'scripts/biomes/mountain/mountain_hall',
	'scripts/biomes/mountain_tree',
	'scripts/biomes/the_end',
	'scripts/perks/perk_list',
	'scripts/gun/gun',
	'scripts/gun/gun_actions',
	'scripts/gun/gun_extra_modifiers',
	'scripts/gun/procedural/gun_procedural',
	'scripts/gun/procedural/gun_procedural_better',
}

for i, _ in ipairs( lua_append ) do
	ModLuaFileAppend( 'data/' .. _ .. '.lua', empty_path .. _ .. '.lua' )
end

---<<<<<<<<<<<<<<<<<<<<<<<< 开局更改 >>>>>>>>>>>>>>>>>>>>>>>>---

dofile_once( 'data/scripts/perks/perk.lua' )
dofile_once( 'data/scripts/perks/perk_utilities.lua' )

--function OnMagicNumbersAndWorldSeedInitialized( )
--	local perks_info = ''
--
--	for i, _ in ipairs( perk_list ) do
--		perks_info = perks_info .. ( [[["%s"] = "%s",%s]] ) : format( _.ui_name, _.id, '\n' )
--	end
--
--	perks_info = 'return {\n' .. perks_info .. '}'
--
--	ModTextFileSetContent( empty_path .. '_virtual/perks_info.lua', perks_info )
--end

function OnPlayerSpawned( player )
	local x, y, rot, s_x, s_y = EntityGetTransform( player )

	if ( GlobalsGetValue( 'EMPTY_STARTING_CHANGE', '0' ) == '0' ) then
		GlobalsSetValue( 'EMPTY_STARTING_CHANGE', '1' )

		local plat = {
			run_velocity = 57,

			velocity_min_x = -int_huge,
			velocity_max_x = int_huge,
			velocity_min_y = -int_huge,
			velocity_max_y = int_huge,
		}

		local kick = {
			kick_radius = 4,
		}

		if ( ModImageDoesExist( 'mods/niko_player_character/files/entities/scarf/part_2/image_1.png' ) ) then
			---<<<<<<<<<<<< 这是 niko >>>>>>>>>>>>---

			EntityAddTag( player, 'niko' )

			---<<<<<<<<<<<< 生命上限提升 >>>>>>>>>>>>---

			local base_hp = 8000 / get_scale( )

			local max_hp = get_comp_info( player, 'DamageModelComponent', nil, {
				{ 'max_hp', 0 },
			}, nil )

			if ( max_hp < base_hp ) then
				max_hp = base_hp
			else
				max_hp = max_hp + base_hp
			end

			local ct, d_comps = set_comp_value( player, 'DamageModelComponent', nil, {
				air_needed = false,
				fire_damage_amount = 0,
				fire_probability_of_ignition = 0,
				max_hp = max_hp,
				hp = max_hp,
				materials_damage = false,
			}, nil, nil )

			---<<<<<<<<<<<< 生命上限获取提升 >>>>>>>>>>>>---

			GlobalsSetValue( 'HEARTS_MORE_EXTRA_HP_MULTIPLIER', '10' )

			---<<<<<<<<<<<< 生命自然恢复 >>>>>>>>>>>>---

			add_comp_remove_dupli( player, 'LuaComponent', 'niko_regeneration', {
				_tags = 'niko,niko_regeneration',
				execute_every_n_frame = 90,
				script_source_file = empty_path .. 'niko/niko_regeneration.lua',
			} )

			---<<<<<<<<<<<< 机动性增加 >>>>>>>>>>>>---

			plat.run_velocity = 171
			plat.jump_velocity_y = -190
			plat.jump_velocity_x = 180
			plat.fly_speed_max_up = 190
			plat.fly_speed_max_down = 190
			plat.fly_velocity_x = 171
			plat.pixel_gravity = 700
			plat.accel_x = 0.45

			---<<<<<<<<<<<< 无限飞行 >>>>>>>>>>>>---

			set_comp_value( player, 'CharacterDataComponent', nil, {
				climb_over_y = 6,
				flying_needs_recharge = false,
				fly_time_max = int_huge,
				fly_recharge_spd = int_huge,
				fly_recharge_spd_ground = int_huge,
				flying_in_air_wait_frames = 0,
				flying_recharge_removal_frames = 0,
			}, nil, nil )

			---<<<<<<<<<<<< 踢击强化 >>>>>>>>>>>>---

			kick.kick_radius = 16
			kick.kick_knockback = 16
			kick.telekinesis_throw_speed = 75
			kick.max_force = 96
			kick.player_kickforce = 96
			kick.kick_damage = 6400 / get_scale( )
			kick.kick_entities = ',data/entities/misc/crack_ice.xml,'

			---<<<<<<<<<<<< 实用天赋 + 全免疫 >>>>>>>>>>>>---

			perk_pickup( nil, player, 'REMOVE_FOG_OF_WAR', false, false, true )
			perk_pickup( nil, player, 'PEACE_WITH_GODS', false, false, true )
			perk_pickup( nil, player, 'NO_MORE_KNOCKBACK', false, false, true )
			perk_pickup( nil, player, 'BREATH_UNDERWATER', false, false, true )

			for i, _ in ipairs( all_pos_protect_perk ) do
				perk_pickup( nil, player, _, false, false, true )
			end

			---<<<<<<<<<<<< 强效吸金 >>>>>>>>>>>>---

			add_comp_remove_dupli( player, 'LuaComponent', 'niko_attract', {
				_tags = 'niko,niko_attract',
				script_source_file = empty_path .. 'niko/niko_attract.lua',
				execute_every_n_frame = 2,
			}, nil )

			---<<<<<<<<<<<< 施法强化 >>>>>>>>>>>>---

			add_comp_remove_dupli( player, 'LuaComponent', 'niko_shot', {
				_tags = 'niko,niko_shot',
				script_shot = empty_path .. 'niko/niko_shot.lua',
			}, nil )

			---<<<<<<<<<<<< 自带追踪形态 >>>>>>>>>>>>---

			local form = 'homing_form'

			EntityAddTag( player, form )

			add_comp_remove_dupli( player, 'LuaComponent', form, {
				_tags = form,
				script_shot = empty_path .. 'scripts/projectiles/form/homing_form.lua',
			} )

			---<<<<<<<<<<<< 近乎无敌 >>>>>>>>>>>>---

			local base_mul = 1 / 3000

			for i, d_comp in ipairs( d_comps ) do
				for j, _ in ipairs( all_d_muls_no_healing ) do
					local mul = ComponentObjectGetValue2( d_comp, 'damage_multipliers', _ )

					if ( mul > base_mul ) then
						ComponentObjectSetValue2( d_comp, 'damage_multipliers', _, base_mul )
					end
				end
			end

			---<<<<<<<<<<<< 额外效果 >>>>>>>>>>>>---

			---@type table<string|table<string, any>>
			local effs = {
				--9 命
				'respawn',

				--不会被粘液减速
				'no_slow',

				--随时编辑, 16 组
				{
					eff = 'edit',
					count = 16,
				},

				--雷火友好 + 免疫
				'friendly',

				--法力回复
				'mana',

				--额外黄金
				'gold',
			}

			for _, eff in ipairs( effs ) do
				if ( type( eff ) == 'string' ) then
					LoadGameEffectEntityTo( player, empty_path .. 'niko/niko_' .. eff .. '.xml' )
				elseif ( type( eff ) == 'table' ) then
					for i = 1, eff.count, 1 do
						LoadGameEffectEntityTo( player, empty_path .. 'niko/niko_' .. eff.eff .. '.xml' )
					end
				end
			end

			---<<<<<<<<<<<< 点燃气体 >>>>>>>>>>>>---

			local fire_gas = EntityLoad( empty_path .. 'niko/niko_burn.xml' )

			EntityAddChild( player, fire_gas )
		end

		set_comp_value( player, 'CharacterPlatformingComponent', nil, plat, nil, nil )

		set_comp_value( player, 'KickComponent', nil, kick, nil, nil )

		for _, curse in ipairs( all_curses ) do
			if ( ModSettingGet( 'empty_the_blackhole_catgirl.' .. curse ) ) then
				perk_pickup( nil, player, 'EMPTY_' .. curse, false, false, true )
			end
		end
	end
end

---<<<<<<<<<<<<<<<<<<<<<<<< 世界更新前 >>>>>>>>>>>>>>>>>>>>>>>>---

--function OnWorldPreUpdate( )
--	local a, b, c = time_for_vec3( )
--	SetRandomSeed( a + c, b + c )

	--if ( GlobalsGetValue( 'EMPTY_PERK_REMOVE_COUNT', '0' ) ~= '0' ) then
	--	dofile( empty_path .. '' )
	--end
--end
