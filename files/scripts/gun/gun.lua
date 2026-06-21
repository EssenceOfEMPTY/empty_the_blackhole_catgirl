
triphase_reincarnation_check = false

extra_iter = 0

is_mana_form = false
is_pure_form = false

inherit_attr = {
	'extra_entities',
	'game_effect_entities',

	'lifetime_add',
	'speed_multiplier',
	'gravity',
	'bounces',

	'spread_degrees',
	'pattern_degrees',

	'damage_melee_add',
	'damage_projectile_add',
	'damage_explosion_add',
	'damage_explosion',
	'explosion_radius',
	'damage_electricity_add',
	'damage_fire_add',
	'damage_ice_add',
	'damage_drill_add',
	'damage_slice_add',
	'damage_curse_add',
	'damage_healing_add',
	'damage_null_all',
	'damage_critical_chance',

	'knockback_force',

	'trail_material',
	'trail_material_amount',

	'gore_particles',
}

---<<<<<<<<<<<<<<<<<<<<<<<< 原版函数替换 >>>>>>>>>>>>>>>>>>>>>>>>---

local old_clone_action = clone_action

function clone_action( source, target )
	old_clone_action( source, target )

	target.series			= source.series
	target.price			= source.price
	target.max_uses			= source.max_uses
	target.command_type		= source.command_type
	target.command_value	= source.command_value
end

local old__start_shot = _start_shot

function _start_shot( ... )
	triphase_reincarnation_check = false

	old__start_shot( ... )
end

local old_set_current_action = set_current_action

function set_current_action( ... )
	if ( reflecting ) then
		old_set_current_action( ... )
	else
		local desc = c.action_description

		old_set_current_action( ... )

		c.action_description = desc
	end
end

local old_draw_action = draw_action

function draw_action( instant_reload_if_empty )
	local action = nil
	state_cards_drawn = state_cards_drawn + 1

	if ( reflecting ) then
		return
	end

	if ( #deck <= 0 ) then
		if ( instant_reload_if_empty and ( force_stop_draws == false ) ) then
			move_discarded_to_deck( )
			order_deck( )

			start_reload = true
		else
			reloading = true

			return true
		end
	end

	if #deck > 0 then
		action = table.remove( deck, 1 )

		local mana_req = action.mana

		if ( not action.mana ) then
			mana_req = ACTION_MANA_DRAIN_DEFAULT
		end

		if ( is_mana_form ) then
			mana_req = math.floor( mana_req / 3 ) - 5
		end

		if ( mana_req > mana ) then
			OnNotEnoughManaForAction( )
			table.insert( discarded, action )

			return false
		end

		if ( action.uses_remaining == 0 ) then
			table.insert( discarded, action )

			return false
		end

		mana = mana - mana_req
	end

	if ( action ) then
		play_action( action )
	end

	return true
end

local old__play_permanent_card = _play_permanent_card

function _play_permanent_card( ... )
	if ( not is_pure_form ) then
		old__play_permanent_card( ... )
	end
end

---<<<<<<<<<<<<<<<<<<<<<<<< 新增函数 >>>>>>>>>>>>>>>>>>>>>>>>---

---法力形态, 降低施法所需的法力
---@param act boolean
function mana_form( act )
	is_mana_form = act
end

---纯粹形态, 不再释放始终释放
---@param act boolean
function pure_form( act )
	is_pure_form = act
end

---递归形态, 递归上限 +2
---@param act boolean
function rec_form( act )
	if ( act ) then
		recursion_limit = 4
	else
		recursion_limit = 2
	end
end

---迭代形态, 迭代上限 +1
---@param act boolean
function iter_form( act )
	if ( act ) then
		extra_iter = 1
	else
		extra_iter = 0
	end
end

---继承属性地发射投射物
---@param _ table
---@param copy_c table  传给此函数的 copy_c 必须是属性快照（平表），不是对全局 c 的引用
function inherit_shot( _, copy_c )
	local shot = create_shot( _.draw_count )

	for j, v in ipairs( inherit_attr ) do
		shot.state[ v ] = copy_c[ v ]
	end

	shot_structure = { }

	local old_c = c
	c = shot.state

	-- 用 pcall 保护 c 的保存/恢复：draw_actions 中任何异常都不会让 c 永久指向 shot.state
	local ok, err = pcall( draw_actions, shot.num_of_cards_to_draw, _.reload )
	if ( ok ) then
		ok, err = pcall( register_action, shot.state )
	end
	if ( ok ) then
		ok, err = pcall( SetProjectileConfigs )
	end

	c = old_c

	if ( not ok ) then
		error( err, 0 )
	end
end

---发射复合型触发投射物
---@param entity_filename string
---@param trigger_table table<string, any>
function add_projectile_complex( entity_filename, trigger_table )
	if ( reflecting ) then
		Reflection_RegisterProjectile( entity_filename )
		return
	end

	BeginProjectile( entity_filename )

	-- 使用 deep_copy 对全局 c 做深拷贝快照，
	-- 这样即使后续迭代中 c 被修改，copy_c 中的值也不会被污染。
	local copy_c = deep_copy( c )

	for i, _ in ipairs( trigger_table or { } ) do
		_.trigger_type = _.trigger_type or 'trigger'
		_.draw_count = _.draw_count or 1
		_.reload = _.reload or true

		if ( _.trigger_type == 'trigger' ) then
			BeginTriggerHitWorld( )

			if ( _.inherit ) then
				inherit_shot( _, copy_c )
			else
				draw_shot( create_shot( _.draw_count ), _.reload or true )
			end
		elseif ( _.trigger_type == 'timer' ) then
			BeginTriggerTimer( _.timer or 0 )

			if ( _.inherit ) then
				inherit_shot( _, copy_c )
			else
				draw_shot( create_shot( _.draw_count ), _.reload )
			end
		else
			BeginTriggerDeath( )

			if ( _.inherit ) then
				inherit_shot( _, copy_c )
			else
				draw_shot( create_shot( _.draw_count ), _.reload )
			end
		end

		EndTrigger( )
	end

	EndProjectile( )
end
