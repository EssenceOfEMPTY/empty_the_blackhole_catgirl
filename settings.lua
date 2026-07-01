dofile_once( 'data/scripts/lib/mod_settings.lua' )

local mod_id = 'empty_the_blackhole_catgirl'
local language = GameTextGet( '$current_language' )
mod_settings_version = 1

local b1 = '		'
local b2 = b1 .. b1
local b3 = b2 .. b1

mod_settings = {
	--[[

	{
		id = '',
		ui_name = '',
		ui_description = '',
		value_default = nil,
		scope = MOD_SETTING_SCOPE_NEW_GAME | MOD_SETTING_SCOPE_RUNTIME | MOD_SETTING_SCOPE_RUNTIME_RESTART | MOD_SETTING_SCOPE_ONLY_SET_DEFAULT,
	},

	]]--
}

if ( language:find( '中文' ) or language:find( '汉化' ) ) then
	mod_settings = {
		{
			category_id = 'INTRODUCTION',
			ui_name = '一些信息',
			foldable = true,
			_folded = true,
			settings = {
				{
					category_id = 'Q_GROUP',
					ui_name = '黑洞猫娘的 Q 群: 猫娘巢穴',
					foldable = true,
					_folded = true,
					settings = {
						{
							ui_name = '群号: 829721848',
							not_setting = true,
						},
					},
					not_setting = true,
				},
				{
					category_id = 'SP_THANKS',
					ui_name = '特别感谢 ( 排名不分先后 )',
					foldable = true,
					_folded = true,
					settings = {
						{
							category_id = 'WHITELEAF',
							ui_name = 'WhiteLeaf',
							foldable = true,
							_folded = true,
							settings = {
								{
									ui_name = '重绘部分法术图标',
									not_setting = true,
								},
							},
							not_setting = true,
						},
						{
							category_id = 'SHUG',
							ui_name = 'shug',
							foldable = true,
							_folded = true,
							settings = {
								{
									ui_name = '为一些神奇实现提供代码帮助',
									not_setting = true,
								},
							},
							not_setting = true,
						},
						{
							category_id = 'SLPAUS',
							ui_name = 'SlpAus',
							foldable = true,
							_folded = true,
							settings = {
								{
									ui_name = '为一些神奇实现提供代码帮助',
									not_setting = true,
								},
							},
							not_setting = true,
						},
						{
							category_id = 'IMMORTALDAMNED',
							ui_name = 'ImmortalDamned',
							foldable = true,
							_folded = true,
							settings = {
								{
									ui_name = '为一些神奇实现提供代码帮助',
									not_setting = true,
								},
							},
							not_setting = true,
						},
						{
							category_id = 'YAKUMO',
							ui_name = 'oɯnʞɐʎ',
							foldable = true,
							_folded = true,
							settings = {
								{
									ui_name = '为一些神奇实现提供代码帮助',
									not_setting = true,
								},
							},
							not_setting = true,
						},
						{
							category_id = 'TANKSY',
							ui_name = 'Tanksy',
							foldable = true,
							_folded = true,
							settings = {
								{
									ui_name = 'Sellhole 模组的开发者, 同意法术化地搬运他的模组',
									not_setting = true,
								},
							},
							not_setting = true,
						},
						{
							category_id = 'PICKLEDSOSIG',
							ui_name = 'PickledSosig',
							foldable = true,
							_folded = true,
							settings = {
								{
									ui_name = 'Mega Perk Pack 模组的开发者, 最高等级地同意带有修改地搬运他的模组',
									not_setting = true,
								},
							},
							not_setting = true,
						},
						{
							ui_name = '黑洞猫娘非常推荐也去创意工坊游玩以上开发者的模组!',
							not_setting = true,
						},
					},
					not_setting = true,
				},
			},
			not_setting = true,
		},
		{
			category_id = 'SETTINGS_NEW_THINGS',
			ui_name = '新内容设置',
			foldable = true,
			_folded = true,
			settings = {
				{
					id = 'EFFECT_CHANGE_DIAMOND_DIVIDE',
					ui_name = '效果更改: 钻石房间 - 一分为十',
					ui_description = '钻石房间掉落 [ 一分为十 ] 的场合, 额外掉落 [ 一分为十+/- ] 各 1 个',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'EFFECT_CHANGE_CHEST_LIGHT',
					ui_name = '效果更改: 珊瑚宝箱',
					ui_description = '珊瑚宝箱也掉落本模组新增的 [ 一分+/- ] 系列法术 ( 不含 [ 一分为十+/- ] )\n'
						.. b1 .. '且掉落法术数量从 3 增加到 5',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'EFFECT_CHANGE_CHEST_DARK',
					ui_name = '效果更改: 黑暗宝箱',
					ui_description = '黑暗宝箱也掉落本模组新增的 [ 置换术 ] 系列法术\n'
						.. b1 .. '且掉落法术数量从 3 增加到 5',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'LOOT_CHANGE_ALCHEMIST',
					ui_name = '掉落更改: 古代炼金术师',
					ui_description = '[ 古代炼金术师 ] 头目死亡时可能掉落本模组新增的 [ 字符+/- ] 系列法术\n'
						.. b1 .. '且掉落法术数量从 4 增加到 7',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'LOOT_CHANGE_WIZARD',
					ui_name = '掉落更改: 法师领主',
					ui_description = '[ 法师领主 ] 头目死亡时可能掉落本模组新增的 [ 2× ] 系列法术',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'LOOT_CHANGE_FRIEND',
					ui_name = '掉落更改: 大朋友',
					ui_description = '[ 大朋友 ] 头目死亡时解锁并掉落本模组新增的 [ 幻彩 ] 系列法术\n'
						.. b1 .. '禁用此项会使 [ 幻彩 ] 系列法术无需解锁',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'EFFECT_CHANGE_PLAYER_SPEED_CAP',
					ui_name = '效果更改: 玩家 - 速度上限',
					ui_description = '移除玩家的速度上限',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'EFFECT_CHANGE_STONE_AFFECT_IN_INV',
					ui_name = '效果更改: 物品栏生效',
					ui_description = '部分物品手持期间适用的效果在物品栏内时也生效',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'EFFECT_CHANGE_INIT_WAND_BLUE',
					ui_name = '效果更改: 初始蓝杖',
					ui_description = '更改初始蓝杖的各项属性, 含法术池',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'EFFECT_CHANGE_INIT_WAND_RED',
					ui_name = '效果更改: 初始红杖',
					ui_description = '更改初始红杖的各项属性, 含法术池',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'EFFECT_CHANGE_WAND_CONTENT',
					ui_name = '效果更改: 法杖 - 法术',
					ui_description = '法杖生成时可能包含 [ 其他 ] 类法术',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'EFFECT_CHANGE_POTION_HP',
					ui_name = '效果更改: 烧瓶 - 生命',
					ui_description = '将烧瓶的生命上限从 12.5 提升至 400',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'EFFECT_CHANGE_POTION_VOLUME',
					ui_name = '效果更改: 烧瓶 - 容量',
					ui_description = '将烧瓶的容量从 1000 提升至 2000',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'EFFECT_CHANGE_POTION_CONTENT',
					ui_name = '效果更改: 烧瓶 - 内容',
					ui_description = '烧瓶生成时有更多可能的内容物',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'EFFECT_CHANGE_POTION_HIGH_EXPLOSION',
					ui_name = '效果更改: 烧瓶 - 高爆',
					ui_description = '将烧瓶碎裂产生的爆炸的伤害从 0 增加到 325\n'
						.. b1 .. '爆炸半径从 3 增加到 64',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'EFFECT_CHANGE_TEMPLE_HEART_ALSO_BUFF',
					ui_name = '效果更改: 神山生命加成',
					ui_description = '生成于神圣之山的 [ 完全生命再生 ] 也受 [ 更强大的心 ] 天赋影响',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'MAGNIFICENT_CONCLUSION',
					ui_name = '盛大闭幕',
					ui_description = '为玩家增加死亡效果',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
			},
		},
		{
			category_id = 'SETTINGS_WORLDS',
			ui_name = '世界设置',
			foldable = true,
			_folded = true,
			settings = {
				{
					id = 'STARTING_EDIT',
					ui_name = '开局编辑',
					ui_description = '在出生点右侧的山地大厅生成一片法杖编辑区域',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'TELEPORT_TO_PYRAMID',
					ui_name = '金字塔传送门',
					ui_description = '在出生点上方生成一个通往金字塔顶的传送门',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'CHAOS_CONNECTED_WORLD',
					ui_name = '四通八达',
					ui_description =
						'令各生物群系之间增加数量繁多的通路\n'
						.. '代价是区域混乱不堪',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'EASY_NG_PLUS',
					ui_name = '更简单的 NG+',
					ui_description = '降低 NG+ 的难度......各方面',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
			},
		},
		{
			category_id = 'SETTINGS_PERKS',
			ui_name = '天赋设置',
			foldable = true,
			_folded = true,
			settings = {
				{
					id = 'TRUE_POWER_OF_UNLIMITED_SPELLS',
					ui_name = '[ 无限法术 ] 力量解放',
					ui_description =
						'令 [ 无限法术 ] 天赋对此模组、位于此模组加载前加载的模组\n'
						.. '以及原版 Noita 中包含的所有法术均生效',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
			},
		},
		{
			category_id = 'SETTINGS_SPELLS',
			ui_name = '法术设置',
			foldable = true,
			_folded = true,
			settings = {
				{
					id = 'UNLOCK_ALL_SPELL',
					ui_name = '法术无需解锁',
					ui_description = '所有法术无需解锁即可生成',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'SPELL_ALL_EQUAL',
					ui_name = '法术等可能生成',
					ui_description = '所有已解锁法术以相同概率在每个法术等级生成',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'EFFECT_CHANGE_BOMB',
					ui_name = '效果更改: 炸弹',
					ui_description =
						'增加 [ 炸弹 ] 法术的最大使用次数\n'
						.. '对 [ 粘性炸弹 ] 与 [ 弹性炸弹 ] 法术也生效',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'ICON_CHANGE_BLACKHOLE_DEATH_TRIGGER',
					ui_name = '图标更改: 失效触发黑洞',
					ui_description =
						'将 [ 带有失效触发的黑洞 ] 法术图标的角标\n'
						.. b1 .. '从 [ 定时 ] 更改为 [ 失效触发 ]',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'EFFECT_CHANGE_BUBBLESHOT',
					ui_name = '效果更改: 泡泡火花',
					ui_description = '[ 泡泡火花 ] 法术的效果现在符合其法术图标',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'EFFECT_CHANGE_BUBBLESHOT_TRIGGER',
					ui_name = '效果更改: 触发泡泡火花',
					ui_description = '[ 带有触发的泡泡火花 ] 法术的效果现在符合其法术图标',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'ICON_CHANGE_MINE_DEATH_TRIGGER',
					ui_name = '图标更改: 失效触发不稳晶体',
					ui_description =
						'将 [ 带有失效触发的不稳晶体 ] 法术图标的角标\n'
						.. b1 .. '从 [ 触发 ] 更改为 [ 失效触发 ]',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'ICON_CHANGE_PIPE_BOMB_DEATH_TRIGGER',
					ui_name = '图标更改: 失效触发休眠晶体',
					ui_description =
						'将 [ 带有失效触发的休眠晶体 ] 法术图标的角标\n'
						.. b1 .. '从 [ 触发 ] 更改为 [ 失效触发 ]',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'ICON_CHANGE_SUMMON_EGG_DEATH_TRIGGER',
					ui_name = '图标更改: 召唤失效触发蛋',
					ui_description =
						'将 [ 召唤带有失效触发的蛋 ] 法术图标的角标\n'
						.. b1 .. '从 [ 触发 ] 更改为 [ 失效触发 ]',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
			},
		},
		{
			category_id = 'SETTINGS_ENEMIES',
			ui_name = '敌怪设置',
			foldable = true,
			_folded = true,
			settings = {
				{
					id = 'SPAWN_MANY_ENEMIES',
					ui_name = '刷怪+',
					ui_description = '刷怪率大幅提升, 0 号诅咒',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'NO_KUMMITUS',
					ui_name = '再无幻影',
					ui_description = '历史幻象不再生成',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
			},
		},
		{
			category_id = 'SETTINGS_CURSES',
			ui_name = '诅咒设置',
			foldable = true,
			_folded = true,
			settings = {
				{
					ui_name =
						'如果你正在寻找某种挑战......\n'
						.. b1 .. '那么这就是了',
					not_setting = true,
				},
				{
					id = 'CURSE_MONK',
					ui_name = '和尚',
					ui_description = '新游戏开始时, 你获得 [ 诅咒: 和尚 ]',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'CURSE_ALWAYS_SHUFFLE',
					ui_name = '始终乱序',
					ui_description = '新游戏开始时, 你获得 [ 诅咒: 始终乱序 ]',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'CURSE_SHORT_WAND',
					ui_name = '短杖',
					ui_description = '新游戏开始时, 你获得 [ 诅咒: 短杖 ]',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'CURSE_MALICE_WASHES_OVER',
					ui_name = '邪念冲刷而过',
					ui_description = '新游戏开始时, 你获得 [ 诅咒: 邪念冲刷而过 ]',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'CURSE_REALITY_SHIFT',
					ui_name = '现实变换',
					ui_description = '新游戏开始时, 你获得 [ 诅咒: 现实变换 ]',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'CURSE_GUARANTEED_LOSE',
					ui_name = '“保送”',
					ui_description = '新游戏开始时, 你获得 [ 诅咒: “保送” ]',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'CURSE_GRAVITY_FREE',
					ui_name = '力场解放',
					ui_description = '新游戏开始时, 你获得 [ 诅咒: 力场解放 ]',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'CURSE_DEATH_TRAIL',
					ui_name = '死亡轨迹',
					ui_description = '新游戏开始时, 你获得 [ 诅咒: 死亡轨迹 ]',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},--[[
				{
					id = 'CURSE_FURIOUS_COCKTAIL',
					ui_name = '狂乱的鸡尾酒',
					ui_description = '新游戏开始时, 你获得 [ 诅咒: 狂乱的鸡尾酒 ]',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},]]--
			},
		},
		{
			category_id = 'SETTINGS_VISIONS',
			ui_name = '视觉设置',
			foldable = true,
			_folded = true,
			settings = {
				{
					id = 'VISION_IMPROVE',
					ui_name = '视野提升',
					ui_description = '150% 视野宽高',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'REMOVE_LOW_HP_FLASH',
					ui_name = '移除闪屏',
					ui_description = '低生命值时不再闪烁屏幕警告',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
			},
		},
		{
			category_id = 'SETTINGS_BUGS_AND_CHEESE',
			ui_name = '漏洞 & 轮椅设置',
			foldable = true,
			_folded = true,
			settings = {
				{
					id = 'BUGFIX_SPELL_TO_POWER',
					ui_name = '漏洞修复: 法转力',
					ui_description = '修复 [ 法术变力量 ] 法术在特定状况下导致游戏崩溃的漏洞',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'BUGFIX_DUPE_MAX_HP_FROM_WORMRAIN',
					ui_name = '漏洞修复: 蠕虫雨刷血',
					ui_description = '修复通过 [ 蠕虫雨 ] 法术无限刷取追加生命上限的漏洞',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'BUGFIX_DUPE_MAX_HP_FROM_HEARTY',
					ui_name = '漏洞修复: 心绞痛刷血',
					ui_description = '修复通过 [ 心绞痛 ] 状态永久增加生命上限的漏洞',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'BUGFIX_DUPE_DMG_MULTI_FROM_VULNERABLE',
					ui_name = '漏洞修复: 易伤刷抗性',
					ui_description = '修复通过 [ 易伤 ] 状态永久降低承伤系数的漏洞',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'BUGFIX_CONNOISSEUR_OF_WANDS',
					ui_name = '漏洞修复: 魔杖鉴赏家',
					ui_description = '修复通过 [ 狂暴魔药 ] 等方式极其简单地击败魔杖鉴赏家的漏洞',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'BUGFIX_HAND_OF_MASTER',
					ui_name = '漏洞修复: 法师之手',
					ui_description = '修复隔空控制物品移动的漏洞',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'CHEESE_CHANGE_CHAINSAW',
					ui_name = '轮椅更改: 链锯',
					ui_description = '作为施法延迟变成 0 的代替, 链锯现在 -30 帧施法延迟',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
			},
		},
		{
			id = 'DISPLAY_DEATH_COUNT',
			ui_name = '显示死亡次数',
			ui_description = '玩家生成时在屏幕左下角提示死亡次数',
			value_default = false,
			scope = MOD_SETTING_SCOPE_RUNTIME_RESTART,
		},
		{
			id = 'COMMAND_FEEDBACK',
			ui_name = '命令反馈',
			ui_description = '命令法术将会在左下角反馈执行状态',
			value_default = true,
			scope = MOD_SETTING_SCOPE_RUNTIME_RESTART,
		},
		{
			id = 'SVAROG_TRANSLATION',
			ui_name = '翻译: 伊芙琳娜',
			ui_description = '将部分生物的名称替换为与 伊芙琳娜 相关的文本',
			value_default = false,
			scope = MOD_SETTING_SCOPE_RUNTIME_RESTART,
		},
	}
else
	mod_settings = {
		{
			category_id = 'EMPTY_MOD_SETTINGS_INTRODUCTION',
			ui_name = 'Some Messages',
			foldable = true,
			_folded = true,
			settings = {
				{
					category_id = 'SP_THANKS',
					ui_name = 'Special thanks ( rankings are not in particular order )',
					foldable = true,
					_folded = false,
					settings = {
						{
							category_id = 'WHITELEAF',
							ui_name = 'WhiteLeaf',
							foldable = true,
							_folded = true,
							settings = {
								{
									ui_name = 'Redraw some spell icons',
									not_setting = true,
								},
							},
							not_setting = true,
						},
						{
							category_id = 'SHUG',
							ui_name = 'shug',
							foldable = true,
							_folded = true,
							settings = {
								{
									ui_name = 'Provide code help for some magical implementations',
									not_setting = true,
								},
							},
							not_setting = true,
						},
						{
							category_id = 'SLPAUS',
							ui_name = 'SlpAus',
							foldable = true,
							_folded = true,
							settings = {
								{
									ui_name = 'Provide code help for some magical implementations',
									not_setting = true,
								},
							},
							not_setting = true,
						},
						{
							category_id = 'IMMORTALDAMNED',
							ui_name = 'ImmortalDamned',
							foldable = true,
							_folded = true,
							settings = {
								{
									ui_name = 'Provide code help for some magical implementations',
									not_setting = true,
								},
							},
							not_setting = true,
						},
						{
							category_id = 'YAKUMO',
							ui_name = 'oɯnʞɐʎ',
							foldable = true,
							_folded = true,
							settings = {
								{
									ui_name = 'Provide code help for some magical implementations',
									not_setting = true,
								},
							},
							not_setting = true,
						},
						{
							category_id = 'TANKSY',
							ui_name = 'Tanksy',
							foldable = true,
							_folded = true,
							settings = {
								{
									ui_name = 'Developer of Sellhole, grant permission to adapt his mod into spell form',
									not_setting = true,
								},
							},
							not_setting = true,
						},
						{
							category_id = 'PICKLEDSOSIG',
							ui_name = 'PickledSosig',
							foldable = true,
							_folded = true,
							settings = {
								{
									ui_name =
										'Developer of Mega Perk Pack, grant highest level of permission to adapt\n'
										..	b1 .. 'his mod with modifications',
									not_setting = true,
								},
							},
							not_setting = true,
						},
						{
							ui_name =
								'Blackhole catgirl heavily recommend also trying aforementioned\n'
								..	b1 .. "developers' mods on Workshop!",
							not_setting = true,
						},
					},
					not_setting = true,
				},
			},
			not_setting = true,
		},		{
			category_id = 'SETTINGS_NEW_THINGS',
			ui_name = 'New Content Settings',
			foldable = true,
			_folded = true,
			settings = {
				{
					id = 'EFFECT_CHANGE_DIAMOND_DIVIDE',
					ui_name = 'Effect Change: Diamond Room - Divide by 10',
					ui_description = 'When [ Divide by 10 ] drops in Diamond Room, additionally drops 1 [ Divide by 10+ ] and 1 [ Divide by 10- ] each',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'EFFECT_CHANGE_CHEST_LIGHT',
					ui_name = 'Effect Change: Coral Chest',
					ui_description = 'Coral Chest also drops [ Divide+/- ] series spells added by this mod ( excluding [ Divide by 10+/- ] )\n'
						.. b1 .. 'and increases number of spell drops from 3 to 5',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'EFFECT_CHANGE_CHEST_DARK',
					ui_name = 'Effect Change: Dark Chest',
					ui_description = 'Dark Chest also drops [ ALL ] series spells added by this mod\n'
						.. b1 .. 'and increases number of spell drops from 3 to 5',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'LOOT_CHANGE_ALCHEMIST',
					ui_name = 'Loot Change: Ancient Alchemist',
					ui_description = '[ Ancient Alchemist ] Boss may drop [ Greek Letter+/- ] series spells added by this mod on death\n'
						.. b1 .. 'and increases number of spell drops from 4 to 7',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'LOOT_CHANGE_WIZARD',
					ui_name = 'Loot Change: Wizard Lord',
					ui_description = '[ Wizard Lord ] Boss may drop [ 2× ] series spells added by this mod on death',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'LOOT_CHANGE_FRIEND',
					ui_name = 'Loot Change: Big Friend',
					ui_description = '[ Big Friend ] Boss unlocks and drops [ Colorful ] series spells added by this mod on death\n'
						.. b1 .. 'disabling this makes [ Colorful ] series spells require no unlock',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'EFFECT_CHANGE_PLAYER_SPEED_CAP',
					ui_name = 'Effect Change: Player - Speed Cap',
					ui_description = 'Remove player speed cap',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'EFFECT_CHANGE_STONE_AFFECT_IN_INV',
					ui_name = 'Effect Change: Inventory Effect',
					ui_description = 'Effects that normally apply while held also apply from inventory for some items',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'EFFECT_CHANGE_INIT_WAND_BLUE',
					ui_name = 'Effect Change: Starting Blue Wand',
					ui_description = 'Change various attributes of starting blue wand, including spell pool',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'EFFECT_CHANGE_INIT_WAND_RED',
					ui_name = 'Effect Change: Starting Red Wand',
					ui_description = 'Change various attributes of starting red wand, including spell pool',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'EFFECT_CHANGE_WAND_CONTENT',
					ui_name = 'Effect Change: Wand - Spells',
					ui_description = 'Wands may contain spells of type [ Other ] when generated',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'EFFECT_CHANGE_POTION_HP',
					ui_name = 'Effect Change: Flask - HP',
					ui_description = 'Increase flask HP from 12.5 to 400',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'EFFECT_CHANGE_POTION_VOLUME',
					ui_name = 'Effect Change: Flask - Capacity',
					ui_description = 'Increase flask capacity from 1000 to 2000',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'EFFECT_CHANGE_POTION_CONTENT',
					ui_name = 'Effect Change: Flask - Content',
					ui_description = 'Flasks have more possible contents when spawned',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'EFFECT_CHANGE_POTION_HIGH_EXPLOSION',
					ui_name = 'Effect Change: Flask - High Explosion',
					ui_description = 'Increase damage of explosion from flask shattering from 0 to 325\n'
						.. b1 .. 'explosion radius from 3 to 64',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'EFFECT_CHANGE_TEMPLE_HEART_ALSO_BUFF',
					ui_name = 'Effect Change: Holy Mountain Healing Buff',
					ui_description = '[ Full Health Restore ] spawned in Holy Mountain is also affected by [ Stronger Hearts ] perk',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'MAGNIFICENT_CONCLUSION',
					ui_name = 'Magnificent Conclusion',
					ui_description = 'Add a death effect for player',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
			},
		},
		{
			category_id = 'SETTINGS_WORLDS',
			ui_name = 'Settings about Worlds',
			foldable = true,
			_folded = true,
			settings = {
				{
					id = 'STARTING_EDIT',
					ui_name = 'Starting Edit',
					ui_description = 'Generates a wand editing area in Mountain Hall to right of spawn point',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'TELEPORT_TO_PYRAMID',
					ui_name = 'Pyramid Teleport',
					ui_description = 'Generates a portal to top of Pyramid above spawn point',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'CHAOS_CONNECTED_WORLD',
					ui_name = 'Thoroughfare',
					ui_description =
						'Adds numerous passages between biomes\n'
						.. 'but making area chaotic',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'EASY_NG_PLUS',
					ui_name = 'Easier NG+',
					ui_description = 'Lower NG+ difficulty... in every way',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
			},
		},
		{
			category_id = 'SETTINGS_PERKS',
			ui_name = 'Settings about Perks',
			foldable = true,
			_folded = true,
			settings = {
				{
					id = 'TRUE_POWER_OF_UNLIMITED_SPELLS',
					ui_name = 'True Power of [ Unlimited Spells ]',
					ui_description =
						'Make [ Unlimited Spells ] perk effective for all spells in this mod,\n'
						.. 'mods loaded before this mod, and vanilla Noita',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
			},
		},
		{
			category_id = 'SETTINGS_SPELLS',
			ui_name = 'Settings about Spells',
			foldable = true,
			_folded = true,
			settings = {
				{
					id = 'UNLOCK_ALL_SPELL',
					ui_name = 'No Need Unlock Spells',
					ui_description = 'All spells can spawn without needing to be unlocked',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'SPELL_ALL_EQUAL',
					ui_name = 'Spells Spawn with Equal Chance',
					ui_description = 'All unlocked spells have equal chance to spawn at every spell level',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'EFFECT_CHANGE_BOMB',
					ui_name = 'Effect Change: Bomb',
					ui_description =
						'increase max uses of [ Bomb ] spell\n'
						.. 'also affect [ Sticky bomb ] and [ Bouncy bomb ] spell',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'ICON_CHANGE_BLACKHOLE_DEATH_TRIGGER',
					ui_name = 'Icon Change: Blackhole with Death Trigger',
					ui_description =
						'Change icon corner mark of [ Blackhole with death trigger ]\n'
						.. b1 .. 'from [ Timer ] to [ Death Trigger ]',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'EFFECT_CHANGE_BUBBLESHOT',
					ui_name = 'Effect Change: Bubble Spark',
					ui_description = 'Effect of [ Bubble spark ] spell now matches its icon',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'EFFECT_CHANGE_BUBBLESHOT_TRIGGER',
					ui_name = 'Effect Change: Bubble Spark with Trigger',
					ui_description = 'Effect of [ Bubble spark with trigger ] spell now matches its icon',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'ICON_CHANGE_MINE_DEATH_TRIGGER',
					ui_name = 'Icon Change: Unstable Crystal with Death Trigger',
					ui_description =
						'Change icon corner mark of [ Unstable Crystal with Death Trigger ]\n'
						.. b1 .. 'from [ Trigger ] to [ Death Trigger ]',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'ICON_CHANGE_PIPE_BOMB_DEATH_TRIGGER',
					ui_name = 'Icon Change: Dormant Crystal with Death Trigger',
					ui_description =
						'Change icon corner mark of [ Dormant Crystal with Death Trigger ]\n'
						.. b1 .. 'from [ Trigger ] to [ Death Trigger ]',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'ICON_CHANGE_SUMMON_EGG_DEATH_TRIGGER',
					ui_name = 'Icon Change: Summon Egg with Death Trigger',
					ui_description =
						'Change icon corner mark of [ Summon egg with death trigger ]\n'
						.. b1 .. 'from [ Trigger ] to [ Death Trigger ]',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
			},
		},
		{
			category_id = 'SETTINGS_ENEMIES',
			ui_name = 'Settings about Enemies',
			foldable = true,
			_folded = true,
			settings = {
				{
					id = 'SPAWN_MANY_ENEMIES',
					ui_name = 'Enemy Spawn Rate+',
					ui_description = 'Enemy spawn rate is greatly increased',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'NO_KUMMITUS',
					ui_name = 'No More Illusions',
					ui_description = "Kummitus don't spawn any more",
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
			},
		},
		{
			category_id = 'SETTINGS_CURSES',
			ui_name = 'Settings about CURSEs',
			foldable = true,
			_folded = true,
			settings = {
				{
					ui_name =
						'If you are looking for some challenges......\n'
						.. b1 .. 'then this is it',
					not_setting = true,
				},
				{
					id = 'CURSE_MONK',
					ui_name = 'Monk',
					ui_description = 'At beginning of new round of game, you get [ Curse: Monk ]',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'CURSE_ALWAYS_SHUFFLE',
					ui_name = 'Always Shuffle',
					ui_description = 'At beginning of new round of game, you get [ Curse: Always Shuffle ]',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'CURSE_SHORT_WAND',
					ui_name = 'Short Wand',
					ui_description = 'At beginning of new round of game, you get [ Curse: Short Wand ]',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'CURSE_MALICE_WASHES_OVER',
					ui_name = 'Malice Washes Over',
					ui_description = 'At beginning of new round of game, you get [ Curse: Malice Washes Over ]',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'CURSE_REALITY_SHIFT',
					ui_name = 'Reality Shift',
					ui_description = 'At beginning of new round of game, you get [ Curse: Reality Shift ]',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'CURSE_GUARANTEED_LOSE',
					ui_name = '“Guaranteed Win”',
					ui_description = 'At beginning of new round of game, you get [ Curse: “Guaranteed Win” ]',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'CURSE_GRAVITY_FREE',
					ui_name = 'Force Field Liberation',
					ui_description = 'At beginning of new round of game, you get [ Curse: Force Field Liberation ]',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'CURSE_DEATH_TRAIL',
					ui_name = 'Death Trail',
					ui_description = 'At beginning of new round of game, you get [ Curse: Death Trail ]',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},--[[
				{
					id = 'CURSE_FURIOUS_COCKTAIL',
					ui_name = 'Furious Cocktail',
					ui_description = 'At beginning of new round of game, you get [ Curse: Furious Cocktail ]',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},]]--
			},
		},
		{
			category_id = 'SETTINGS_VISIONS',
			ui_name = 'Settings about Visions',
			foldable = true,
			_folded = true,
			settings = {
				{
					id = 'VISION_IMPROVE',
					ui_name = 'Vision Improve',
					ui_description = '150% vision width and height',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'REMOVE_LOW_HP_FLASH',
					ui_name = 'Remove Screen Flash',
					ui_description = 'No longer flash screen warning when at low health',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
			},
		},
		{
			category_id = 'SETTINGS_BUGS_AND_CHEESE',
			ui_name = 'Settings about Bugs & Cheeses',
			foldable = true,
			_folded = true,
			settings = {
				{
					id = 'BUGFIX_SPELL_TO_POWER',
					ui_name = 'Bugfix: Spells to Power',
					ui_description = 'Fix crash caused by [ Spells to Power ] under certain conditions',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'BUGFIX_DUPE_MAX_HP_FROM_WORMRAIN',
					ui_name = 'Bugfix: Worm Rain HP Dupe',
					ui_description = 'Fix infinite max health dupe through [ Worm Rain ] spell',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'BUGFIX_DUPE_MAX_HP_FROM_HEARTY',
					ui_name = 'Bugfix: Heartache HP Dupe',
					ui_description = 'Fix permanent max health increase dupe through [ Heartache ] status',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'BUGFIX_DUPE_DMG_MULTI_FROM_VULNERABLE',
					ui_name = 'Bugfix: Vulnerable Resistance Dupe',
					ui_description = 'Fix permanent damage multiplier reduction dupe through [ Vulnerable ] status',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'BUGFIX_CONNOISSEUR_OF_WANDS',
					ui_name = 'Bugfix: Connoisseur of Wands',
					ui_description = 'Fix exploit of defeating Connoisseur of Wands extremely easily via [ Berserkium ] etc.',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'BUGFIX_HAND_OF_MASTER',
					ui_name = 'Bugfix: Hand of Master',
					ui_description = 'Fix exploit of moving items from distance',
					value_default = true,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
				{
					id = 'CHEESE_CHANGE_CHAINSAW',
					ui_name = 'Cheese Change: Chainsaw',
					ui_description = 'Instead of setting fire rate wait to 0, Chainsaw now -30 frames fire rate wait',
					value_default = false,
					scope = MOD_SETTING_SCOPE_NEW_GAME,
				},
			},
		},
		{
			id = 'DISPLAY_DEATH_COUNT',
			ui_name = 'Display Death Count',
			ui_description = 'Show death count at bottom-left screen corner on player spawn',
			value_default = false,
			scope = MOD_SETTING_SCOPE_RUNTIME_RESTART,
		},
		{
			id = 'COMMAND_FEEDBACK',
			ui_name = 'Command Feedback',
			ui_description = 'Command spells will display execution feedback at bottom-left',
			value_default = true,
			scope = MOD_SETTING_SCOPE_RUNTIME_RESTART,
		},
		{
			id = 'SVAROG_TRANSLATION',
			ui_name = 'Translation: Svarog',
			ui_description =
				'Replace some of creatures names with text related to Svarog\n\n'
				.. 'this setting is useless for you, reason:\n'
				.. b1 .. 'Svarog is a chinese Noita streamer\n'
				.. b1 .. 'this setting only replace some chinese translations of his jokes',
			value_default = false,
			scope = MOD_SETTING_SCOPE_ONLY_SET_DEFAULT,
		},
	}
end

function ModSettingsUpdate( init_scope )
	local old_version = mod_settings_get_version( mod_id )
	mod_settings_update( mod_id, mod_settings, init_scope )
end

function ModSettingsGuiCount( )
	return mod_settings_gui_count( mod_id, mod_settings )
end

function ModSettingsGui( gui, in_main_menu )
	mod_settings_gui( mod_id, mod_settings, gui, in_main_menu )
end
