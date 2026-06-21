dofile_once( 'data/scripts/lib/utilities.lua' )

empty_path = 'mods/empty_the_blackhole_catgirl/files/'

int_huge = 2147483647

math_2p = 2 * math.pi
math_e = math.exp( 1 )
epsilon = 0.0003

chunk_len = 512

all_curses = {
	'CURSE_MONK',
	'CURSE_ALWAYS_SHUFFLE',
	'CURSE_SHORT_WAND',
	'CURSE_MALICE_WASHES_OVER',
	'CURSE_REALITY_SHIFT',
	'CURSE_GUARANTEED_LOSE',
	'CURSE_GRAVITY_FREE',
	'CURSE_DEATH_TRAIL',
	--'CURSE_FURIOUS_COCKTAIL',
}

all_d_muls = {
	'melee',
	'projectile',
	'explosion',
	'electricity',
	'fire',
	'ice',
	'drill',
	'slice',
	'physics_hit',
	'radioactive',
	'poison',
	'curse',
	'holy',
	'healing',
}

all_d_muls_no_healing = {
	'melee',
	'projectile',
	'explosion',
	'electricity',
	'fire',
	'ice',
	'drill',
	'slice',
	'physics_hit',
	'radioactive',
	'poison',
	'curse',
	'holy',
}

all_proj_dmg = {
	'melee',
	'explosion',
	'electricity',
	'fire',
	'ice',
	'slice',
	'drill',
	'physics_hit',
	'radioactive',
	'poison',
	'curse',
	'holy',
	'healing',
}

all_proj_dmg_0_dmg_by_type = {
	{ 'damage_by_type', 'melee', 0 },
	{ 'damage_by_type', 'explosion', 0 },
	{ 'damage_by_type', 'electricity', 0 },
	{ 'damage_by_type', 'fire', 0 },
	{ 'damage_by_type', 'ice', 0 },
	{ 'damage_by_type', 'slice', 0 },
	{ 'damage_by_type', 'drill', 0 },
	{ 'damage_by_type', 'physics_hit', 0 },
	{ 'damage_by_type', 'radioactive', 0 },
	{ 'damage_by_type', 'poison', 0 },
	{ 'damage_by_type', 'curse', 0 },
	{ 'damage_by_type', 'holy', 0 },
	{ 'damage_by_type', 'healing', 0 },
}

all_pos_protect_perk = {
	'PROTECTION_FIRE',
	'PROTECTION_RADIOACTIVITY',
	'PROTECTION_EXPLOSION',
	'PROTECTION_MELEE',
	'PROTECTION_ELECTRICITY',
	'EMPTY_PROTECTION_GLUE',
	'EMPTY_PROTECTION_SHOCK',
	'EMPTY_PROTECTION_FREEZE',
	'EMPTY_PROTECTION_VENOMOUS_CURSE',
	'EMPTY_PROTECTION_LAVA',
	'EMPTY_PROTECTION_ACID',
	'EMPTY_PROTECTION_SLICE',
	'EMPTY_PROTECTION_POISON',
	'EMPTY_PROTECTION_PLASMA',
	'EMPTY_PROTECTION_BLINDNESS',
	'EMPTY_PROTECTION_NEUTRALIZED',
	'EMPTY_PROTECTION_TWITCHY',
	'EMPTY_PROTECTION_HEARTY',
	'EMPTY_PROTECTION_POLYMORPH',
	'EMPTY_PROTECTION_TOUCH_MAGIC',
}

all_stains = {
	'1',
	'wet',
	'oiled',
	'blooded',
	'5',
	'6',
	'7',
	'8',
	'9',
	'10',
	'11',
	'12',
	'13',
	'14',
	'15',
	'16',
	'17',
	'18',
	'19',
	'20',
	'21',
	'22',
	'23',
	'24',
	'25',
	'urine',
	'27',
	'28',
	'29',
	'30',
	'31',
	'32',
	'33',
	'34',
	'35',
	'36',
	'37',
	'38',
	'39',
	'40',
	'41',
	'42',
}

all_tag = {
	hit = 'hittable',
	player = 'player_unit',
	poly_player = 'polymorphed_player',
	enemy = 'enemy',
}

orbit_loc_fix = {
	{ x = 12, y = 12 },
	{ x = 12, y = -12 },
	{ x = -12, y = 12 },
	{ x = -12, y = -12 },
}

max_adjust = 180

---打印一切信息, 此函数仅用于调试;
---正式版本中不应该看见任何地方调用这个函数
---@param info any
---@param key string?
---@param tab_count number?
function info_print( info, key, tab_count )
	if ( key == nil ) then
		key = ''
	end
	if ( tab_count == nil ) then
		tab_count = 0
	end

	local typ = type( info )

	if ( typ == 'table' ) then
		if ( tab_count == 0 ) then
			print( '< ' .. typ .. ' > ' .. key .. ': {' )
		else
			print( string.rep( '\t', tab_count ) .. '< ' .. typ .. ' > ' .. key .. ': {' )
		end

		for i, _ in pairs( info or { } ) do
			info_print( _, i, tab_count + 1 )
		end

		if ( tab_count == 0 ) then
			print( '}' )
		else
			print( string.rep( '\t', tab_count ) .. '}' )
		end
	else
		if ( tab_count == 0 ) then
			print( '< ' .. typ .. ' > ' .. key .. ': ' .. tostring( info ) )
		else
			print( string.rep( '\t', tab_count ) .. '< ' .. typ .. ' > ' .. key .. ': ' .. tostring( info ) )
		end
	end
end

---检测 num 是否是正常数值
---@param num any
---@return boolean is_not_0_num
function is_not_nan_num( num )
	return type( num ) == 'number' and num == num
end

---检测 num 是否是正常数值且不为 0
---@param num any
---@return boolean is_not_0_num
function is_not_0_num( num )
	return is_not_nan_num( num ) and num ~= 0
end

---检测 str 是否是字符串且不为空字符串
---@param str any
---@return boolean is_not_nil_str
function is_not_nil_str( str )
	return type( str ) == 'string' and str ~= ''
end

---检测 v_table 是否是表且不为空表
---@param v_table any
---@return boolean is_not_nil_table
function is_not_nil_table( v_table )
	return type( v_table ) == 'table' and next( v_table ) ~= nil
end

---检测 num 是否为整数
---@param num any
---@return boolean is_int
function is_int( num )
	return type( num ) == 'number' and num == math.floor( num )
end

---判断实体是否存活
---@param entity number
---@return boolean is_alive
function is_alive( entity )
	return ( is_not_0_num( entity ) and EntityGetIsAlive( entity ) )
end

---检查 search 内是否包含 value
---@param value any
---@param search table|nil
---@return boolean is_in
function is_in( value, search )
	if ( type( search ) ~= 'table' ) then
		return false
	end

	for _, v in ipairs( search ) do
		if ( v == value ) then
			return true
		end
	end

	return false
end

---判断实体是否为玩家, 含变形
---@param entity number
---@return boolean is_player
function is_player( entity )
	return ( is_not_0_num( entity )
		and ( EntityHasTag( entity, 'player_unit' ) or EntityHasTag( entity, 'polymorphed_player' ) ) )
end

---判断实体是否为敌怪
---@param entity number
---@return boolean is_enemy
function is_enemy( entity )
	return ( is_not_0_num( entity )
		and ( EntityHasTag( entity, 'enemy' ) ) )
end

---检测是否是子实体
---@param entity number
---@return boolean is_child
function is_child( entity )
	return not ( entity == EntityGetRootEntity( entity ) )
end

---手动 math.atan( y, x )
---@param y number
---@param x number
---@return number atan_yx
function atan( y, x )
	if ( x > 0 ) then
		return math.atan( y / x )
	elseif ( x < 0 ) then
		if ( y >= 0 ) then
			return math.atan( y / x ) + math.pi
		else
			return math.atan( y / x ) - math.pi
		end
	else
		if ( y > 0 ) then
			return math.pi * 0.5
		elseif ( y < 0 ) then
			return -math.pi * 0.5
		else
			return 0
		end
	end
end

---显示重要信息
---@param title string
---@param desc string?
function imp_print( title, desc )
	if ( type( title ) == 'string' and type( desc ) == 'string' ) then
		GamePrintImportant( title, desc )
	elseif ( type( title ) == 'string' and type( desc ) ~= 'string' ) then
		GamePrintImportant( title, '' )
	end
end

---发送提示信息
---@param name string
---@param ... any
function command_print( name, ... )
	GamePrint( name .. ' : ' .. GameTextGet( ... ) )
end

if ( not ModSettingGet( 'empty_the_blackhole_catgirl.COMMAND_FEEDBACK' ) ) then
	command_print = function ( name, ... )
		--
	end
end

---返回关于时间的 3 个数, 主要作为随机种子使用
---@return number year_day_min
---@return number mon_hour_sec
---@return number frame_num
function time_for_vec3( )
	local year1, mon1, day1, hour1, min1, sec1 = GameGetDateAndTimeLocal( )
	local year2, mon2, day2, hour2, min2, sec2 = GameGetDateAndTimeUTC( )

	local year, mon, day, hour, min, sec =
		( year1 or 0 ) + ( year2 or 0 ),
		( mon1 or 0 ) + ( mon2 or 0 ),
		( day1 or 0 ) + ( day2 or 0 ),
		( hour1 or 0 ) + ( hour2 or 0 ),
		( min1 or 0 ) + ( min2 or 0 ),
		( sec1 or 0 ) + ( sec2 or 0 )

	return ( year + day + min ), ( mon + hour + sec ), GameGetFrameNum( )
end

---设置随机数种子, 返回 entity 的位置
---@param entity number?
---@return number? x
---@return number? y
function set_r_seed( entity )
	local a, b, c = time_for_vec3( )

	if ( is_not_0_num( entity ) and type( entity ) == 'number' ) then
		local x, y = EntityGetTransform( entity )

		SetRandomSeed( x - a + c, y - b + c )

		return x, y
	else
		SetRandomSeed( a - c, b - c )

		return nil, nil
	end
end

---返回平行世界位置
---@param x number
---@param y number
---@return table<number, number, number, number> pw_info
function get_para_pos( x, y )
	local p_info = { }

	p_info.pw_lr, p_info.pw_ud = GetParallelWorldPosition( x, y )

	local m_width, m_high = BiomeMapGetSize( )

	local x_half, y_half = chunk_len * m_width / 2, chunk_len * m_high / 2

	p_info.p_x = ( ( x + x_half ) % m_width ) - x_half
	p_info.p_y = ( ( y + y_half ) % m_high ) - y_half

	return p_info
end

---返回任意数据的全大写数据类型
---@param any any
---@return string upper_type
function upper_type( any )
	local any_type = string.upper( type( any ) )

	if ( any_type == 'TABLE' ) then
		return 'NUMBER[ ]'
	else
		return any_type
	end
end

---根据 k_table 模板表创建键值全为 v 的表
---@param k_table table|nil
---@param v any
---@return table v_table
function create_all_table( k_table, v )
	local v_table = { }

	for i, _ in ipairs( k_table or { } ) do
		v_table[ _ ] = v
	end

	return v_table
end

---Lanczos 近似系数 ( g = 7, n = 9 )
local lanc_coeff = {
	0.99999999999980993,
	676.5203681218851,
	-1259.1392167224028,
	771.32342877765313,
	-176.61502916214059,
	12.507343278686905,
	-0.13857109526572012,
	9.9843695780195716e-6,
	1.5056327351493116e-7,
}

---math.log( Γ( z ) )
---@param z number
---@return number log_Γ_z
function ln_gamma( z )
	if ( z < 0.5 ) then
		return math.log( math.pi / math.sin( math.pi * z ) ) - ln_gamma( 1 - z )
	else
		z = z - 1

		local x = lanc_coeff[ 1 ]

		for i = 2, #lanc_coeff, 1 do
			x = x + lanc_coeff[ i ] / ( z + i - 1 )
		end

		local t = z + #lanc_coeff - 0.5

		return math.log( math.sqrt( math_2p ) ) + ( z + 0.5 ) * math.log( t ) - t + math.log( x )
	end
end

---Γ( z )
---@param z number
---@return number Γ_z
function gamma( z )
	return math.exp( ln_gamma( z ) )
end

---z 的阶乘, 支持解析延拓
---@param z number
---@return number fact_z
function fact( z )
	if ( z == 0 ) then
		return 1
	elseif ( z < 0 and z == math.floor( z ) ) then
		return 0
	else
		return gamma( z + 1 )
	end
end

---深度拷贝表, 支持嵌套表和循环引用保护
---@param t table
---@return table t
function deep_copy( t )
	local visited = { }

	local function _deep_copy( t )
		if ( type( t ) ~= 'table' ) then
			return t
		end

		if ( visited[ t ] ) then
			return visited[ t ]
		end

		local copy = { }
		visited[ t ] = copy

		for k, v in pairs( t ) do
			copy[ _deep_copy( k ) ] = _deep_copy( v )
		end

		return copy
	end

	return _deep_copy( t )
end

---构造承伤乘数表 t
---@param num number
---@return table<string, number> d_muls
function construct_d_muls( num )
	local t = { }

	for i, _ in ipairs( all_d_muls ) do
		t[ _ ] = num
	end

	return t
end

---以包含 2 项的数组作为最值获取随机数
---@param target number[]
---@return number
function get_random_between_range( target )
	return Random( target[ 1 ], target[ 2 ] )
end

---获取 target 内的随机 1 项
---@param target table
---@return any
function get_random_from( target )
	return target[ Random( 1, #target ) ]
end

---向 main 内加入 merge 内的每项;
---可在加入前清空 main 或在加入后清空 merge
---@param main table
---@param merge table
---@param is_clean_main boolean? --默认为 false
---@param is_clean_merge boolean? --默认为 true
function add_table( main, merge, is_clean_main, is_clean_merge )
	if ( is_clean_main == nil ) then
		is_clean_main = false
	end
	if ( is_clean_merge == nil ) then
		is_clean_merge = true
	end

	if ( is_clean_main ) then
		for _ = #main, 1, -1 do
			main[ _ ] = nil
		end
	end

	if ( merge ) then
		for _ = 1, #merge do
			table.insert( main, merge[ _ ] )
		end

		if ( is_clean_merge ) then
			for _ = #merge, 1, -1 do
				merge[ _ ] = nil
			end
		end
	end
end

---在 main 内通过 id 查找并替换 replace 内的每项;
---设置 pre_id 的场合, 将对比 pre_id 并将 id 更改为新的 id;
---可在替换后清空 replace
---@param main table
---@param replace table
---@param is_clean_replace boolean? --默认为 true
function update_table_by_id( main, replace, is_clean_replace )
	if ( is_clean_replace == nil ) then
		is_clean_replace = true
	end

	for i, new in ipairs( replace ) do
		for j, old in ipairs( main ) do
			if ( type( new.pre_id ) == 'string' ) then
				if ( old.id == new.pre_id ) then
					new.pre_id = nil

					for k, _ in pairs( new ) do
						main[ j ][ k ] = _
					end

					break
				end
			else
				if ( old.id == new.id ) then
					for k, _ in pairs( new ) do
						main[ j ][ k ] = _
					end

					break
				end
			end
		end
	end

	if ( is_clean_replace ) then
		for _ = #replace, 1, -1 do
			replace[ _ ] = nil
		end
	end
end

---将 main 逆序并返回;
---可修改 main
---@param main table
---@param is_change_main boolean? --默认为 true
---@return table reversed
function reverse_table( main, is_change_main )
	if ( is_change_main == nil ) then
		is_change_main = true
	end

	local reversed, len = { }, #main

	for i = len, 1, -1 do
		table.insert( reversed, main[ i ] )
	end

	if ( is_change_main ) then
		for _, v in ipairs( reversed ) do
			main[ _ ] = v
		end
	end

	return reversed
end

---交换 2 个 table 的内容
---@param table1 table
---@param table2 table
function swap_table( table1, table2 )
	local tmp = { }

	add_table( tmp, table1, false, false )
	add_table( table1, table2, true, true )
	add_table( table2, tmp, false, false )
end

---将 from 中第 pos_from 项移动至 to 中 pos_to 位置
---@param from table
---@param to table
---@param pos_from integer? --默认为 1
---@param pos_to integer? --默认为 #to + 1
function add_table_1( from, to, pos_from, pos_to )
	if ( pos_from == nil ) then
		pos_from = 1
	end

	if ( pos_to == nil ) then
		pos_to = #to + 1
	end

	table.insert( to, pos_to, table.remove( from, pos_from ) )
end

---将 merge 中 顺数 / 倒数 前 count 项 保持 / 反转 顺序移动至 main 中 最前 / 最后 位置
---@param from table
---@param to table
---@param count integer
---@param from_front boolean? --默认为 true
---@param to_front boolean? --默认为 false
---@param is_reverse_order boolean? --默认为 false
function add_table_count( from, to, count, from_front, to_front, is_reverse_order )
	if ( count < 1 ) then
		return
	end
	if ( count > #from ) then
		count = #from
	end

	if ( from_front == nil ) then
		from_front = true
	end
	if ( to_front == nil ) then
		to_front = false
	end
	if ( is_reverse_order == nil ) then
		is_reverse_order = false
	end

	local tmp = { }

	for _ = 1, count, 1 do
		local pin1, pin2 = _, #from

		if ( is_reverse_order and from_front ) or ( not is_reverse_order and not from_front ) then
			pin1 = 1
		end

		if ( from_front ) then
			pin2 = 1
		end

		table.insert( tmp, pin1, table.remove( from, pin2 ) )
	end

	if ( to_front ) then
		for _ = 1, count, 1 do
			table.insert( to, _, table.remove( tmp, 1 ) )
		end
	else
		for _ = 1, count, 1 do
			table.insert( to, #to + 1, table.remove( tmp, 1 ) )
		end
	end
end

--- ( 未使用 ) 确保 check 内有 keys 属性路径
---@param check table
---@param keys string[]
---@return table ensure
function ensure_table( check, keys )
	for i, _ in ipairs( keys or { } ) do
		if ( type( check[ _ ] ) ~= 'table' ) then
			check[ _ ] = { }
		end

		check = check[ _ ]
	end

	return check
end

---从 random_table 中随机选取 count 项;
---count 或 random_table 的长度小于 1 时返回空表;
---count 大于 random_table 的长度时变作与 random_table 的长度相同
---@param random_table table
---@param count number
---@return table select_items
function random_gets( random_table, count )
	if ( #random_table < 1 or count < 1 ) then
		return { }
	end

	local original, select_items = { }, { }
	add_table( original, random_table, false, false )

	count = math.min( count, #original )

	local a, b, c = time_for_vec3( )
	SetRandomSeed( a - c, b - c )

	for _ = 1, count, 1 do
		table.insert( select_items, table.remove( original, Random( 1, #original ) ) )
	end

	return select_items
end

---为仅包含 number / string 类型的 table 去重, 返回去重后的 table
---@param num_str_table any
---@return table remove_dupli
function remove_dupes( num_str_table )
	local seen, res = { }, { }

	for _, each in ipairs( num_str_table ) do
		local str_each = tostring( each )
		if ( not seen[ str_each ] ) then
			seen[ str_each ] = true
			table.insert( res, each )
		end
	end

	return res
end

---为 location 排序;
---仅可用于法术的 action( ) 中对 卡组 · 手卡 · 墓地 的操作
---@param location table[]
---@return table[] location_sort
function loc_sort( location )
	if ( #location < 2 ) then
		return location
	end

	table.sort( location, function( a, b )
		local a_index = a.deck_index or 0
		local b_index = b.deck_index or 0

		return a_index < b_index
	end)

	return location
end

---打乱 loc 的顺序;
---仅可用于法术的 action( ) 中对 卡组 · 手卡 · 墓地 的操作
---@param loc table
---@return table location_shuffle
function loc_shuffle( loc )
	if ( #loc < 2 ) then
		return loc
	end

	for _ = #loc, 2, -1 do
		local diff = Random( #loc, 1 )
		loc[ _ ], loc[ diff ] = loc[ diff ], loc[ _ ]
	end

	return loc
end

---获取全局变量的数值
---@param key string
---@param value number
---@return number res
function get_globals_num( key, value )
	local res = tonumber( GlobalsGetValue( key ) )

	if ( type( res ) == 'number' and res == res ) then
		return res
	else
		return value
	end
end

---设置全局变量的数值
---@param key string
---@param value number
function set_globals_num( key, value )
	if ( type( value ) == 'number' and value == value ) then
		GlobalsSetValue( key, tostring( value ) )
	end
end

---获取模组设置的值
---@param key string
---@param value any
---@return any res
function get_settings_num( key, value )
	local res = ModSettingGet( key )

	if ( res ~= nil ) then
		return res
	else
		return value
	end
end

---设置模组设置的值
---@param key string
---@param value any
function set_settings_num( key, value )
	if ( value ~= nil ) then
		ModSettingSet( key, value )
	end
end

---倍乘实体的生命上限
---@param entity number
---@param calc_type string
---@param mul number
---@param is_full_hp boolean? -- 默认为 true
function max_hp_mul( entity, calc_type, mul, is_full_hp )
	if ( is_has_comp( entity, 'DamageModelComponent', nil, nil ) ) then
		is_full_hp = is_full_hp or true

		local max_hp = get_comp_value( entity, 'DamageModelComponent', nil, {
			{ 'max_hp', 1 / get_scale( ) },
		}, nil )

		if ( calc_type == '*' ) then
			max_hp = max_hp * mul
		elseif ( calc_type == '/' ) then
			max_hp = max_hp / mul
		end

		if ( max_hp > 0 ) then
			if ( is_full_hp ) then
				set_comp_value( entity, 'DamageModelComponent', nil, {
					max_hp = max_hp,
					hp = max_hp,
				}, nil, nil )
			else
				set_comp_value( entity, 'DamageModelComponent', nil, {
					max_hp = max_hp,
				}, nil, nil )
			end
		end
	end
end

---倍乘实体的承伤系数
---@param entity number
---@param calc_type string
---@param mul number|table<string, number>
function d_comps_mul( entity, calc_type, mul )
	if ( is_has_comp( entity, 'DamageModelComponent', nil, nil ) ) then
		if ( is_not_nil_table( mul ) and type( mul ) == 'table' ) then
			if ( calc_type == '*' ) then
				set_comp_obj_value( entity, 'DamageModelComponent', nil, nil, nil, function ( comp )
					for _, v in pairs( mul ) do
						local cur_mul = ComponentObjectGetValue2( comp, 'damage_multipliers', _ ) or 1

						ComponentObjectSetValue2( comp, 'damage_multipliers', _, cur_mul * v )
					end
				end )
			elseif ( calc_type == '/' ) then
				set_comp_obj_value( entity, 'DamageModelComponent', nil, nil, nil, function ( comp )
					for _, v in pairs( mul ) do
						local cur_mul = ComponentObjectGetValue2( comp, 'damage_multipliers', _ ) or 1

						ComponentObjectSetValue2( comp, 'damage_multipliers', _, cur_mul / v )
					end
				end )
			end
		elseif ( type( mul ) == 'number' ) then
			if ( calc_type == '*' ) then
				set_comp_obj_value( entity, 'DamageModelComponent', nil, nil, nil, function ( comp )
					for i, _ in ipairs( all_d_muls ) do
						local cur_mul = ComponentObjectGetValue2( comp, 'damage_multipliers', _ ) or 1

						ComponentObjectSetValue2( comp, 'damage_multipliers', _, cur_mul * mul )
					end
				end )
			elseif ( calc_type == '/' ) then
				set_comp_obj_value( entity, 'DamageModelComponent', nil, nil, nil, function ( comp )
					for i, _ in ipairs( all_d_muls ) do
						local cur_mul = ComponentObjectGetValue2( comp, 'damage_multipliers', _ ) or 1

						ComponentObjectSetValue2( comp, 'damage_multipliers', _, cur_mul / mul )
					end
				end )
			end
		end
	end
end

---获取实体的速度
---@param entity number
---@return number vel_x
---@return number vel_y
function get_vel( entity )
	local vel = get_comp_value( entity, 'VelocityComponent', nil, {
		{ 'mVelocity', { 0, 0 } }
	}, nil )

	return vel[ 1 ], vel[ 2 ]
end

---设置实体的速度
---@param entity number|number[]
function set_vel( entity, vel_x, vel_y )
	set_comp_value( entity, 'VelocityComponent', nil, {
		{ 'mVelocity', { vel_x, vel_y } }
	}, nil, nil )
end

---获取实体的速度
---@param entity number
---@return number vel_x
---@return number vel_y
function get_char_vel( entity )
	local vel = get_comp_value( entity, 'CharacterDataComponent', nil, {
		{ 'mVelocity', { 0, 0 } }
	}, nil )

	return vel[ 1 ], vel[ 2 ]
end

---设置实体的速度
---@param entity number|number[]
function set_char_vel( entity, vel_x, vel_y )
	set_comp_value( entity, 'CharacterDataComponent', nil, {
		{ 'mVelocity', { vel_x, vel_y } }
	}, nil, nil )
end

---获取速度的模
---@param vel_x number
---@param vel_y number
---@return number length
function get_len( vel_x, vel_y )
	if ( vel_x == 0 ) then
		if ( vel_y == 0 ) then
			return 0
		else
			return vel_y
		end
	else
		if ( vel_y == 0 ) then
			return vel_x
		else
			return sqrt_p2_add( vel_x, vel_y )
		end
	end
end

---根据 num 在 min_num 与 max_num 之间的位置对数地获取 mul
---@param num number
---@param paras table<string, number>
---@return number log_mul
function get_log_mul( num, paras )
	if ( num <= paras.min_num ) then
		return paras.min_log
	elseif ( num >= paras.max_num ) then
		return paras.max_log
	end

	local curve = paras.log_e or 1

	if ( curve <= 0 ) then
		curve = 1
	end

	local num_range = paras.max_num - paras.min_num
	local log_range = paras.max_log - paras.min_log

	local diff = ( num - paras.min_num ) * curve
	local range = num_range * curve

	local log_mul = math.log( diff + 1 ) / math.log( range + 1 )

	return paras.min_log + log_range * log_mul
end

---标准化向量
---@param vel_x number
---@param vel_y number
---@return number vel_x
---@return number vel_y
function normalize( vel_x, vel_y )
	if ( vel_x == 0 and vel_y == 0 ) then
		return 0, 0
	else
		local len = get_len( vel_x, vel_y )

		return vel_x / len, vel_y / len
	end
end

---在不更改速度方向的状态下将速度大小变为 speed
---@param vel_x number
---@param vel_y number
---@param speed number
---@return number vel_x
---@return number vel_y
function change_vel( vel_x, vel_y, speed )
	if ( vel_x == 0 and vel_y == 0 ) then
		return 0, 0
	else
		vel_x, vel_y = normalize( vel_x, vel_y )

		return vel_x * speed, vel_y * speed
	end
end

---将 count 个点以 gap 为间距排列在 x 轴上，整体中心位于 x = 0;
---返回第 num 个点的 x 坐标
---@param count number
---@param gap number
---@param num number
---@return number result
function loc_center_fix( count, gap, num )
	return ( num - ( count - 1 ) / 2 - 1 ) * gap
end

---从 (x1, y1) 出发，向 (x2, y2) 方向移动 dis 距离, 返回终点坐标
---@param x1 number
---@param y1 number
---@param x2 number
---@param y2 number
---@param dis number?
---@return number
---@return number
function move_toward( x1, y1, x2, y2, dis )
	if ( not dis or dis == 0 ) then
		return x1, y1
	else
		local dx, dy = change_vel( x2 - x1, y2 - y1, dis )

		return x1 + dx, y1 + dy
	end
end

---计算 attract 与 mover 之间的引力, 返回 mover 应当产生的动量
---@param mover_x number
---@param mover_y number
---@param attract_x number
---@param attract_y number
---@param dist_full number
---@param coeff number?
---@return number vel_x
---@return number vel_y
function force_by_loc( mover_x, mover_y, attract_x, attract_y, dist_full, coeff )
	coeff = coeff or 72

	local dist = sqrt_p2_add( attract_x - mover_x, attract_y - mover_y )

	if ( dist >= dist_full ) then
		return 0, 0
	end

	local dir = -atan( attract_y - mover_y, attract_x - mover_x )
	local per = ( dist_full - dist ) / dist_full

	return math.cos( dir ) * per * coeff, -math.sin( dir ) * per * coeff
end

---将角度 deg 转换为弧度 rad
---@param deg number
---@return number rad
function deg_to_rad( deg )
	local rad = math.fmod( deg * math.pi / 180.0, math_2p )

	if ( rad > math.pi ) then
		rad = rad - math_2p
	elseif ( rad < -math.pi ) then
		rad = rad + math_2p
	end

	return rad
end

---在不更改速度大小的状态下将速度方向在原基础上逆时针旋转 angle°
---@param vel_x number
---@param vel_y number
---@param angle number
---@return number vel_x
---@return number vel_y
function rot_vel( vel_x, vel_y, angle )
	if ( vel_x == 0 and vel_y == 0 ) then
		return 0, 0
	else
		local rad = deg_to_rad( -angle )
		local sin, cos = math.sin( rad ), math.cos( rad )

		return cos * vel_x - sin * vel_y, sin * vel_x + cos * vel_y
	end
end

---在不更改速度大小的状态下将速度方向在正右方基础上逆时针旋转 angle°
---@param vel_x number
---@param vel_y number
---@param angle number
---@return number vel_x
---@return number vel_y
function abs_rot_vel( vel_x, vel_y, angle )
	if ( vel_x == 0 and vel_y == 0 ) then
		return 0, 0
	else
		local rad, speed = deg_to_rad( -angle ), sqrt_p2_add( vel_x, vel_y )
		local sin, cos = math.sin( rad ), math.cos( rad )

		return cos * speed, sin * speed
	end
end

---获取 NG+ 数
---@return number NG_count
function get_ng_count( )
	return tonumber( SessionNumbersGetValue( 'NEW_GAME_PLUS_COUNT' ) ) or 0
end

---获取生命显示比例
---@return number
function get_scale( )
	return tonumber( MagicNumbersGetValue( 'GUI_HP_MULTIPLIER' ) ) or 0
end

---获取金钱数
---@param entity number
---@return number money
function get_money( entity )
	local wallet_comp, money = EntityGetFirstComponent( entity, 'WalletComponent' ), 0

	if ( wallet_comp ) then
		money = ComponentGetValue2( wallet_comp, 'money' ) or 0
	end

	return money
end

---将 num 的值调整至 min, max 之间
---@param min number
---@param num number
---@param max number
---@return number num
function cap( min, num, max )
	if ( min == max ) then
		return max
	end
	if ( min > max ) then
		min, max = max, min
	end

	return math.max( min, math.min( num, max ) )
end

---将 num 的值循环调整至 min, max 之间
---@param num number
---@param min number
---@param max number
---@return number mul_cap
function mod_cap( num, min, max )
	if ( min == max ) then
		return max
	end

	if ( min > max ) then
		min, max = max, min
	end

	if ( min <= num and num <= max ) then
		return num
	end

	local range = max - min
	local mod = ( num - min ) % range

	if ( mod == 0 ) then
		if ( num < min ) then
			return min
		else
			return max
		end
	else
		return min + mod
	end
end

---返回 math.sqrt( a ^ 2 + b ^ 2 )
---@param a number
---@param b number
---@return number sqrt_p2_add
function sqrt_p2_add( a, b )
	return math.sqrt( a ^ 2 + b ^ 2 )
end

---将 int rgba 打包为 uint32
---@param r number
---@param g number
---@param b number
---@param a number
---@return number rgba
function pack_rgba( r, g, b, a )
	return 0x1000000 * r + 0x10000 * g + 0x100 * b + a
end

---获取当前根实体
---@return number root_entity
function get_root_entity( )
	return EntityGetRootEntity( GetUpdatedEntityID( ) )
end

---获取当前实体
---@return number
function get_up_entity( )
	return GetUpdatedEntityID( )
end

---获取当前实体, 返回表
---@return table<string, number>
function get_up_entity_table( )
	local update = GetUpdatedEntityID( )

	return {
		root = EntityGetRootEntity( update ),
		update = update,
	}
end

---获取 comp 组件所在的实体
---@param comp any
---@return number
function comp_get_entity( comp )
	return ComponentGetEntity( comp )
end

---获取投射物的发射者
---@param proj number
---@param def_shooter number
---@return number shooter
function get_shooter( proj, def_shooter )
	local shooter = get_comp_value( proj, 'ProjectileComponent', nil, {
		{ 'mWhoShot', nil },
	}, nil )

	return shooter or def_shooter
end

---获取所有玩家, 包括变形中的
---@return number[] players
function get_all_players( )
	local players = EntityGetWithTag( 'player_unit' ) or { }

	add_table( players, EntityGetWithTag( 'polymorphed_player' ) or { } )

	return players
end

---获取所有投射物
---@return number[] projs
function get_all_projs( )
	local projs = EntityGetWithTag( 'projectile' ) or { }

	add_table( projs, EntityGetWithTag( 'projectile_player' ) or { } )

	return remove_dupes( projs )
end

---获取实体光标位置
---@param entity number
---@return number cur_x
---@return number cur_y
function get_cur_xy( entity )
	local cur = get_comp_value( entity, 'ControlsComponent', nil, {
		{ 'mMousePosition', { 0, 0 } }
	}, nil )

	return cur[ 1 ], cur[ 2 ]
end

---获取最近的玩家
---@param tar_id number?
---@param tar_x number?
---@param tar_y number?
---@return number? closest
---@return number? dist
function get_closest_player( tar_id, tar_x, tar_y )
	local x, y = nil, nil

	if ( tar_id ) then
		x, y = EntityGetTransform( tar_id )
	elseif ( tar_x ) and ( tar_y ) then
		x, y = tar_x, tar_y
	end

	local closest, final_x, final_y = nil, nil, nil

	if ( x ) and ( y ) then
		local players = get_all_players( )

		if ( #players > 1 ) then
			local min_distance = math.huge

			for _, player in ipairs( players ) do
				local px, py = EntityGetTransform( player )

				if ( px and py ) then
					local dist_pow_2 = ( x - px ) ^ 2 + ( y - py ) ^ 2

					if ( dist_pow_2 < min_distance ) then
						min_distance = dist_pow_2

						closest = player

						final_x, final_y = px, py
					end
				end
			end
		elseif ( #players == 1 ) then
			closest = players[ 1 ]

			final_x, final_y = EntityGetTransform( closest )
		end
	end

	if ( closest ) then
		return closest, sqrt_p2_add( x - final_x, y - final_y )
	else
		return 0, nil
	end
end

---创建自定义价值的黄金块
---@param x number
---@param y number
---@param value number
---@param unlimit_time boolean?
function create_gold( x, y, value, unlimit_time )
	local gold = EntityLoad( empty_path .. 'entities/items/pickup/goldnugget.xml', x, y )

	if ( unlimit_time ) then
		remove_all_comp( gold, 'VariableStorageComponent', 'empty_gold_timer', nil )
	end

	if ( is_not_0_num( value ) ) then
		set_comp_value( gold, 'VariableStorageComponent', 'empty_gold_value', {
			value_int = value,
		}, nil, nil )

		if ( value > 30000 ) then
			set_comp_value( gold, 'PhysicsImageShapeComponent', nil, {
				image_file = 'data/items_gfx/easter/golden_idol_big.png',
			}, nil, nil )
		end
	end

	set_comp_value( gold, 'VelocityComponent', nil, {
		mVelocity = { Random( -10, 10 ), Random( -10, 10 ) },
	}, nil, nil )
end

---为实体复制组件 - 未完成, 请勿使用此函数
---@param entity number|number[]
---@param comp number|number[]
function copy_comp( entity, comp )
	if ( type( entity ) == 'number' ) then
		entity = { entity }
	end
	if ( type( comp ) == 'number' ) then
		comp = { comp }
	end

	for i, _ in ipairs( comp ) do
		local comp_mem = ComponentGetMembers( _ )
		local real_comp = { }

		for k, v in pairs( comp_mem or { } ) do
			--TODO
		end

		for j, e in ipairs( entity ) do
			add_comp( entity, '', real_comp )
		end
	end
end

---复制投射物 - 未完成, 请勿使用此函数
---@param proj number|number[]
---@param source number
function copy_proj( proj, source )
	if ( type( proj ) == 'number' ) then
		proj = { proj }
	end

	local comps = get_all_comp( source )

	for i, _ in ipairs( proj ) do
		remove_all_comp( _, nil, nil, nil )
	end

	copy_comp( proj, comps )
end

---移除投射物速度组件的速度上限
---@param projs number|number[]
function remove_speed_limit( projs )
	set_comp_value( projs, 'VelocityComponent', nil, {
		apply_terminal_velocity = false,
		terminal_velocity = int_huge,
		limit_to_max_velocity = false,
	}, nil, nil )
end

---将实体传送至 ( x, y )
---@param entity number|number[]
---@param x number
---@param y number
---@param rot number?
---@return number tp_count
function tp( entity, x, y, rot )
	if ( type( entity ) == 'number' ) then
		entity = { entity }
	end

	local count = 0

	for i, _ in ipairs( entity or { } ) do
		if ( is_not_0_num( _ ) ) then
			EntitySetTransform( _, x, y, rot )

			count = count + 1
		end
	end

	return count
end

---检测此投射物是否需要追踪
---( 无物吞、无传送组件和猫娘模组内置传送脚本 )
---@param proj number
---@return boolean is_need_homing
function is_need_homing( proj )
	return not (
		is_has_comp( proj, 'CellEaterComponent', nil, nil )
		or is_has_comp( proj, 'TeleportProjectileComponent', nil, nil )
		or is_has_comp( proj, 'LuaComponent', 'empty_teleport', nil )
	)
end

---检测法术是否是被复制的
---@param rec number|nil
---@param iter number|nil
---@param series string|nil
---@param specific string|nil
---@return boolean is_spell_copy
function is_spell_copy( rec, iter, series, specific )
	return rec ~= nil or iter ~= nil or series ~= nil or specific ~= nil
end

---获取每个 entity 实体中类型为 comp_type 的组件
---@param entity number|number[]
---@param comp_type string?
---@param tag string?
---@param name string?
---@return number[] comps
function get_all_comp( entity, comp_type, tag, name )
	local comps = { }

	if ( type( entity ) == 'number' ) then
		entity = { entity }
	elseif ( entity == nil or not is_not_nil_table( entity ) ) then
		return { }
	end

	if ( is_not_nil_str( comp_type ) and type( comp_type ) == 'string' ) then
		if ( is_not_nil_str( tag ) and type( tag ) == 'string' ) then
			for i, _ in ipairs( entity ) do
				add_table( comps, EntityGetComponentIncludingDisabled( _, comp_type, tag ) or { } )
			end
		else
			for i, _ in ipairs( entity ) do
				add_table( comps, EntityGetComponentIncludingDisabled( _, comp_type ) or { } )
			end
		end
	else
		for i, _ in ipairs( entity ) do
			add_table( comps, EntityGetAllComponents( _ ) )
		end
	end

	if ( is_not_nil_str( name ) ) then
		for _ = #comps, 1, -1 do
			if ( ComponentGetValue2( comps[ _ ], 'name' ) ~= name ) then
				table.remove( comps, _ )
			end
		end
	end

	return comps
end

---返回 entity 实体中是否有类型为 comp_type 的组件
---@param entity number
---@param comp_type string
---@param tag string?
---@param name string?
---@return boolean is_has_comp
function is_has_comp( entity, comp_type, tag, name )
	local comps = get_all_comp( entity, comp_type, tag, name )

	return #comps > 0
end

---返回 entity 实体中首个类型为 comp_type 的组件内属性为 field_table 每个 "键" 的值;
---没有的场合用 field_table 对应"键"的值代替
---@param entity number
---@param comp_type string
---@param tag string|nil
---@param field_table table<string, any>[]|nil
---@param name string?
---@return any ...
function get_comp_value( entity, comp_type, tag, field_table, name )
	local values, comp = { }, nil

	if ( type( tag ) == 'string' ) then
		if ( is_not_nil_str( name ) ) then
			local comps = EntityGetComponent( entity, comp_type, tag )

			for i, _ in ipairs( comps or { } ) do
				local v = ComponentGetValue2( _, 'name' )

				if ( v and v == name ) then
					comp = _

					break
				end
			end
		else
			comp = EntityGetFirstComponent( entity, comp_type, tag )
		end
	else
		if ( is_not_nil_str( name ) ) then
			local comps = EntityGetComponent( entity, comp_type )

			for i, _ in ipairs( comps or { } ) do
				local v = ComponentGetValue2( _, 'name' )

				if ( v and v == name ) then
					comp = _

					break
				end
			end
		else
			comp = EntityGetFirstComponent( entity, comp_type )
		end
	end

	if ( comp ) then
		for _, t in ipairs( field_table or { } ) do
			local value = { ComponentGetValue2( comp, t[ 1 ] ) }

			if ( #value == 0 ) then
				table.insert( values, t[ 2 ] )
			elseif ( #value == 1 ) then
				table.insert( values, value[ 1 ] )
			else
				table.insert( values, value )
			end
		end
	else
		for _, t in ipairs( field_table or { } ) do
			table.insert( values, t[ 2 ] )
		end
	end

	return unpack( values )
end

---返回 entity 实体中首个类型为 comp_type 的组件内子对象的属性为 field_table 每个 "键" 的值；
---没有的场合用 field_table 对应"键"的默认值代替
---@param entity number
---@param comp_type string
---@param tag string|nil
---@param field_table table<string, string, any>[]|nil
---@param name string?
---@return any ...
function get_comp_obj_value( entity, comp_type, tag, field_table, name )
	local values, comp = { }, nil

	if ( type( tag ) == 'string' ) then
		if ( is_not_nil_str( name ) ) then
			local comps = EntityGetComponent( entity, comp_type, tag )

			for i, _ in ipairs( comps or { } ) do
				local v = ComponentGetValue2( _, 'name' )

				if ( v and v == name ) then
					comp = _

					break
				end
			end
		else
			comp = EntityGetFirstComponent( entity, comp_type, tag )
		end
	else
		if ( is_not_nil_str( name ) ) then
			local comps = EntityGetComponent( entity, comp_type )

			for i, _ in ipairs( comps or { } ) do
				local v = ComponentGetValue2( _, 'name' )

				if ( v and v == name ) then
					comp = _

					break
				end
			end
		else
			comp = EntityGetFirstComponent( entity, comp_type )
		end
	end

	if ( comp ) then
		for _, t in ipairs( field_table or { } ) do
			local v = ComponentObjectGetValue2( comp, t[ 1 ], t[ 2 ] )

			if ( v == nil ) then
				v = t[ 3 ]
			end

			table.insert( values, v )
		end
	else
		for _, t in ipairs( field_table or { } ) do
			table.insert( values, t[ 3 ] )
		end
	end

	return unpack( values )
end

---为每个 entity 实体增加类型为 comp_type 的以 comp_table 构建的组件
---@param entity number|number[]
---@param comp_type string
---@param comp_table table
---@return number comps_count
---@return number[] affect_comps
function add_comp( entity, comp_type, comp_table )
	if ( type( entity ) == 'number' ) then
		entity = { entity }
	elseif ( entity == nil or not is_not_nil_table( entity ) ) then
		return 0, { }
	end

	local comps = { }

	for _, e in ipairs( entity ) do
		local comp = EntityAddComponent2( e, comp_type, comp_table )

		table.insert( comps, comp )
	end

	return #comps, comps
end

---为每个 entity 实体增加类型为 comp_type 的以 comp_table 构建的组件;
---当元素为字符串时，增量为 comp_table[ 元素 ] ;
---当元素为 { key, inc } 表时，增量为 inc ;
---会删除多余的组件, 返回影响组件的总数、操作方法以及受影响后仍存在的组件表
---@param entity number|number[]
---@param comp_type string
---@param tag string|nil
---@param comp_table table
---@param prolong_table (string|{[1]:string,[2]:number})[]?
---@param name string|nil
---@return number comps_count
---@return string method
---@return number[] affect_comps
function add_comp_prolong( entity, comp_type, tag, comp_table, prolong_table, name )
	local count, method = 0, 'nil'

	if ( type( entity ) == 'number' ) then
		entity = { entity }
	elseif ( entity == nil or not is_not_nil_table( entity ) ) then
		return 0, method, { }
	end

	local comps = get_all_comp( entity, comp_type, tag, name )

	if ( #comps == 0 ) then
		method, comps = 'add', { }

		for _, e in ipairs( entity ) do
			local comp = EntityAddComponent2( e, comp_type, comp_table )

			table.insert( comps, comp )
		end

		count = #comps
	else
		method, count = 'prolong', #comps
		local op_comps, oped_entity = { }, { }

		add_table( op_comps, comps, false, true )

		for _, comp in ipairs( op_comps ) do
			local op_entity = comp_get_entity( comp )

			if ( is_in( op_entity, oped_entity ) ) then
				EntityRemoveComponent( op_entity, comp )
			else
				table.insert( oped_entity, op_entity )

				for i, k in ipairs( prolong_table or { } ) do
					if ( type( k ) == 'table' and type( k[ 1 ] ) == 'string' and type( k[ 2 ] ) == 'number' ) then
						local value = ComponentGetValue2( comp, k[ 1 ] )
						ComponentSetValue2( comp, k[ 1 ], value + k[ 2 ] )
					elseif ( type( k ) == 'string' and type( comp_table[ k ] ) == 'number' ) then
						local value = ComponentGetValue2( comp, k )
						ComponentSetValue2( comp, k, value + comp_table[ k ] )
					end
				end

				table.insert( comps, comp )
			end
		end
	end

	return count, method, comps
end

---为每个 entity 实体增加类型为 comp_type 的以 comp_table 构建的组件;
---会删除多余的组件, 返回影响组件的总数、操作方法以及受影响后仍存在的组件表
---@param entity number|number[]
---@param comp_type string
---@param tag string|nil
---@param comp_table table
---@param name string?
---@return number comps_count
---@return string method
---@return number[] affect_comps
function add_comp_remove_dupli( entity, comp_type, tag, comp_table, name )
	local count, method = 0, 'nil'

	if ( type( entity ) == 'number' ) then
		entity = { entity }
	elseif ( entity == nil or not is_not_nil_table( entity ) ) then
		return 0, method, { }
	end

	local comps = get_all_comp( entity, comp_type, tag, name )

	if ( #comps == 0 ) then
		method, comps = 'add', { }

		for _, e in ipairs( entity ) do
			local comp = EntityAddComponent2( e, comp_type, comp_table )

			table.insert( comps, comp )
		end

		count = #comps
	else
		method, count = 'change', #comps
		local op_comps, oped_entity = { }, { }

		add_table( op_comps, comps, false, true )

		for _, comp in ipairs( op_comps ) do
			local op_entity = comp_get_entity( comp )

			if ( is_in( op_entity, oped_entity ) ) then
				EntityRemoveComponent( op_entity, comp )
			else
				table.insert( oped_entity, op_entity )

				for k, v in pairs( comp_table ) do
					ComponentSetValue2( comp, k, v )
				end

				table.insert( comps, comp )
			end
		end
	end

	return count, method, comps
end

---将每个 entity 实体所有类型为 comp_type 的组件的值按照 v_table 设置;
---在传入 func 时对每个类型为 comp_type 的组件执行一次 func ;
---返回影响组件的总数以及受影响的组件表
---@param entity number|number[]
---@param comp_type string|nil
---@param tag string|nil
---@param v_table table|nil
---@param pre_func function?
---@param aft_func function?
---@return number comps_count
---@return number[] affect_comps
function set_comp_value( entity, comp_type, tag, v_table, pre_func, aft_func )
	if ( type( entity ) == 'number' ) then
		entity = { entity }
	elseif ( entity == nil or not is_not_nil_table( entity ) ) then
		return 0, { }
	end

	local comps = get_all_comp( entity, comp_type, tag )

	if ( is_not_nil_table( v_table ) ) then
		if ( pre_func ) then
			if ( aft_func ) then
				for _, comp in ipairs( comps ) do
					pre_func( comp )

					for k, v in pairs( v_table or { } ) do
						if ( type( v ) == 'table' ) then
							ComponentSetValue2( comp, k, unpack( v ) )
						else
							ComponentSetValue2( comp, k, v )
						end
					end

					aft_func( comp )
				end
			else
				for _, comp in ipairs( comps ) do
					pre_func( comp )

					for k, v in pairs( v_table or { } ) do
						if ( type( v ) == 'table' ) then
							ComponentSetValue2( comp, k, unpack( v ) )
						else
							ComponentSetValue2( comp, k, v )
						end
					end
				end
			end
		else
			if ( aft_func ) then
				for _, comp in ipairs( comps ) do
					for k, v in pairs( v_table or { } ) do
						if ( type( v ) == 'table' ) then
							ComponentSetValue2( comp, k, unpack( v ) )
						else
							ComponentSetValue2( comp, k, v )
						end
					end

					aft_func( comp )
				end
			else
				for _, comp in ipairs( comps ) do
					for k, v in pairs( v_table or { } ) do
						if ( type( v ) == 'table' ) then
							ComponentSetValue2( comp, k, unpack( v ) )
						else
							ComponentSetValue2( comp, k, v )
						end
					end
				end
			end
		end
	else
		if ( pre_func ) then
			if ( aft_func ) then
				for _, comp in ipairs( comps ) do
					pre_func( comp )

					aft_func( comp )
				end
			else
				for _, comp in ipairs( comps ) do
					pre_func( comp )
				end
			end
		else
			if ( aft_func ) then
				for _, comp in ipairs( comps ) do
					aft_func( comp )
				end
			else
				comps = { }
			end
		end
	end

	return #comps, comps
end

---将每个 entity 实体所有类型为 comp_type 的组件内子对象属性按照 v_table 设置;
---在传入 func 时对每个类型为 comp_type 的组件执行一次 func ;
---返回影响组件的总数以及受影响的组件表
---@param entity number|number[]
---@param comp_type string
---@param tag string|nil
---@param v_table table<string, string, any>[]|nil
---@param pre_func function?
---@param aft_func function?
---@return number comps_count
---@return number[] affect_comps
function set_comp_obj_value( entity, comp_type, tag, v_table, pre_func, aft_func )
	if ( type( entity ) == 'number' ) then
		entity = { entity }
	elseif ( entity == nil or not is_not_nil_table( entity ) ) then
		return 0, { }
	end

	local comps = get_all_comp( entity, comp_type, tag )

	if ( is_not_nil_table( v_table ) ) then
		if ( pre_func ) then
			if ( aft_func ) then
				for i, comp in ipairs( comps ) do
					pre_func( comp )

					for j, _ in ipairs( v_table or { } ) do
						if ( type( _[ 3 ] ) == 'table' ) then
							ComponentObjectSetValue2( comp, _[ 1 ], _[ 2 ], unpack( _[ 3 ] ) )
						else
							ComponentObjectSetValue2( comp, _[ 1 ], _[ 2 ], _[ 3 ] )
						end
					end

					aft_func( comp )
				end
			else
				for i, comp in ipairs( comps ) do
					pre_func( comp )

					for j, _ in ipairs( v_table or { } ) do
						if ( type( _[ 3 ] ) == 'table' ) then
							ComponentObjectSetValue2( comp, _[ 1 ], _[ 2 ], unpack( _[ 3 ] ) )
						else
							ComponentObjectSetValue2( comp, _[ 1 ], _[ 2 ], _[ 3 ] )
						end
					end
				end
			end
		else
			if ( aft_func ) then
				for i, comp in ipairs( comps ) do
					for j, _ in ipairs( v_table or { } ) do
						if ( type( _[ 3 ] ) == 'table' ) then
							ComponentObjectSetValue2( comp, _[ 1 ], _[ 2 ], unpack( _[ 3 ] ) )
						else
							ComponentObjectSetValue2( comp, _[ 1 ], _[ 2 ], _[ 3 ] )
						end
					end

					aft_func( comp )
				end
			else
				for i, comp in ipairs( comps ) do
					for j, _ in ipairs( v_table or { } ) do
						if ( type( _[ 3 ] ) == 'table' ) then
							ComponentObjectSetValue2( comp, _[ 1 ], _[ 2 ], unpack( _[ 3 ] ) )
						else
							ComponentObjectSetValue2( comp, _[ 1 ], _[ 2 ], _[ 3 ] )
						end
					end
				end
			end
		end
	else
		if ( pre_func ) then
			if ( aft_func ) then
				for _, comp in ipairs( comps ) do
					pre_func( comp )

					aft_func( comp )
				end
			else
				for _, comp in ipairs( comps ) do
					pre_func( comp )
				end
			end
		else
			if ( aft_func ) then
				for _, comp in ipairs( comps ) do
					aft_func( comp )
				end
			else
				comps = { }
			end
		end
	end

	return #comps, comps
end

---移除每个 entity 实体所有类型为 comp_type 的组件;
---返回影响组件的总数
---@param entity number|number[]
---@param comp_type string?
---@param tag string?
---@param name string?
---@return number comps_count
function remove_all_comp( entity, comp_type, tag, name )
	if ( type( entity ) == 'number' ) then
		entity = { entity }
	elseif ( entity == nil or not is_not_nil_table( entity ) ) then
		return 0
	end

	local comps = get_all_comp( entity, comp_type, tag, name )

	for _, comp in ipairs( comps ) do
		EntityRemoveComponent( EntityGetRootEntity( ComponentGetEntity( comp ) ), comp )
	end

	return #comps
end

---返回每个 entity 实体上的所有子实体
---@param entity number|number[]
---@param tag string?
---@param name string?
---@return number[] childs
function get_all_child( entity, tag, name )
	local childs = { }

	if ( type( entity ) == 'number' ) then
		entity = { entity }
	end

	if ( is_not_nil_str( tag ) ) then
		for _, e in ipairs( entity ) do
			add_table( childs, EntityGetAllChildren( e, tag ) or { } )
		end
	else
		for _, e in ipairs( entity ) do
			add_table( childs, EntityGetAllChildren( e ) or { } )
		end
	end

	if ( is_not_nil_str( name ) ) then
		for _ = #childs, 1, -1 do
			if ( EntityGetName( childs[ _ ] ) ~= name ) then
				table.remove( childs, _ )
			end
		end
	end

	return childs
end

---解除子实体的挂载, 并传送至 ( x, y )
---@param child number|number[]
---@param x number
---@param y number
---@param rot number?
function rem_child( child, x, y, rot )
	if ( type( child ) == 'number' ) then
		child = { child }
	end

	for i, _ in ipairs( child or { } ) do
		EntityRemoveFromParent( _ )
	end

	tp( child, x, y, rot )
end

---解除子实体的挂载, 然后删除
---@param child number|number[]
function rem_del_child( child )
	if ( type( child ) == 'number' ) then
		child = { child }
	end

	for i, _ in ipairs( child or { } ) do
		EntityRemoveFromParent( _ )

		EntityKill( _ )
	end
end

---移除每个 entity 实体上的所有子实体;
---返回影响子实体的总数
---@param entity number|number[]
---@param x number
---@param y number
---@param rot number?
---@param tag string?
---@return number child_count
function rem_all_child( entity, x, y, rot, tag, name )
	local child = get_all_child( entity, tag, name )

	rem_child( child, x, y, rot )

	return #child
end

---移除每个 entity 实体上的所有子实体;
---返回影响子实体的总数
---@param entity number|number[]
---@param tag string?
---@return number child_count
function rem_del_all_child( entity, tag, name )
	local child = get_all_child( entity, tag, name )

	rem_del_child( child )

	return #child
end

---为投射物进行伤害变换
---@param proj number
---@param dmg_type string
---@param mul number? --伤害倍率, 默认 50%
---@param base_dmg number? --基础伤害, 默认 0
function damage_to( proj, dmg_type, mul, base_dmg )
	if ( is_has_comp( proj, 'ProjectileComponent', nil ) ) then
		mul, base_dmg = mul or 0.5, base_dmg or 0

		local sum = 0

		set_comp_value( proj, 'ProjectileComponent', nil, {
			damage = 0,
		}, function ( comp )
			sum = sum + math.abs( ComponentGetValue2( comp, 'damage' ) or 0 )
		end, nil )

		set_comp_obj_value( proj, 'ProjectileComponent', nil, {
			{ 'config_explosion', 'damage', 0 },
		}, function ( comp )
			sum = sum + math.abs( ComponentObjectGetValue2( comp, 'config_explosion', 'damage' ) or 0 )
		end, nil )

		set_comp_obj_value( proj, 'ProjectileComponent', nil, all_proj_dmg_0_dmg_by_type,
		function ( comp )
			for i, _ in ipairs( all_proj_dmg ) do
				sum = sum + math.abs( ComponentObjectGetValue2( comp, 'damage_by_type', _ ) or 0 )
			end
		end, nil )

		sum = base_dmg + sum * mul

		if ( dmg_type == 'projectile' ) then
			set_comp_value( proj, 'ProjectileComponent', nil, {
				damage = sum,
			}, nil, nil )
		elseif ( dmg_type == 'healing' ) then
			set_comp_obj_value( proj, 'ProjectileComponent', nil, {
				{ 'damage_by_type', dmg_type, -sum },
			}, nil, nil )
		else
			set_comp_obj_value( proj, 'ProjectileComponent', nil, {
				{ 'damage_by_type', dmg_type, sum },
			}, nil, nil )
		end
	end
end

---为投射物全伤害乘以伤害倍率
---@param proj number
---@param mul number? --伤害倍率, 默认 200%
---@return boolean is_has_dmg
---@return table<string, number> dmg_data
function damage_mul( proj, mul )
	local is_has_dmg, dmg_data = false, { }

	if ( is_has_comp( proj, 'ProjectileComponent', nil ) ) then
		mul = mul or 2

		local p_dmg = get_comp_value( proj, 'ProjectileComponent', nil, {
			{ 'damage', 0 },
		}, nil )

		if ( p_dmg > 0 ) then
			p_dmg = p_dmg * mul

			set_comp_value( proj, 'ProjectileComponent', nil, {
				damage = p_dmg,
			}, nil, nil )

			is_has_dmg, dmg_data.projectile = true, p_dmg
		end

		local dmg = { }

		local ex_dmg = get_comp_obj_value( proj, 'ProjectileComponent', nil, {
			{ 'config_explosion', 'damage', 0 },
		}, nil )

		if ( ex_dmg > 0 ) then
			ex_dmg = ex_dmg * mul

			table.insert( dmg, {
				'config_explosion', 'damage', ex_dmg
			} )

			is_has_dmg, dmg_data.explosion = true, ex_dmg
		end

		for i, _ in ipairs( all_proj_dmg ) do
			local d = get_comp_obj_value( proj, 'ProjectileComponent', nil, {
				{ 'damage_by_type', _, 0 },
			}, nil )

			if ( d > 0 ) then
				d = d * mul

				table.insert( dmg, {
					'damage_by_type', _, d
				} )

				is_has_dmg, dmg_data[ _ ] = true, d
			end
		end

		if ( #dmg > 0 ) then
			set_comp_obj_value( proj, 'ProjectileComponent', nil, dmg, nil, nil )
		end
	end

	return is_has_dmg, dmg_data
end

---获取一个法杖的始终释放法术信息
---@param wand number
---@return number always_count
---@return number[] always_spells
function get_always( wand )
	local spell, always = get_all_child( wand, 'card_action' ), { }

	for i, _ in ipairs( spell ) do
		local is_always = get_comp_value( _, 'ItemComponent', nil, {
			{ 'permanently_attached', false },
		}, nil )

		if ( is_always ) then
			table.insert( always, _ )
		end
	end

	return #always, always
end

---获取法杖的真实容量
---@param wand number
---@return number real_cap
function get_real_cap( wand )
	return math.floor( EntityGetWandCapacity( wand ) )
end

---转换始终法术数量，并移除超出的普通法术
---增加始终时：从前到后将非始终转为始终
---减少始终时：从后到前将始终转为非始终
---移除超出普通容量时：从末尾掉落非始终法术
---@param wand number
---@param tgt_real_cap number 目标普通容量
---@param tgt_always number 目标始终法术数量
---@return number actual_always 实际调整后的始终法术数量（可能因实体不足而小于目标）
function adjusts_spells( wand, tgt_real_cap, tgt_always )
	local spells, always, non_always = get_all_child( wand ), { }, { }
	local cur_always = get_always( wand )

	for _, card in ipairs( spells ) do
		local is_always = get_comp_value( card, 'ItemComponent', nil, {
			{ 'permanently_attached', false },
		}, nil )

		if ( is_always ) then
			table.insert( always, card )
		else
			table.insert( non_always, card )
		end
	end

	local new_always = cur_always

	if ( tgt_always > cur_always ) then
		local to_convert = math.min( tgt_always - cur_always, #non_always )

		for _ = 1, to_convert do
			local card = non_always[ _ ]

			set_comp_value( card, 'ItemComponent', nil, {
				permanently_attached = true,
			}, nil, nil )
		end

		new_always = cur_always + to_convert
	elseif ( tgt_always < cur_always ) then
		local to_convert = math.min( cur_always - tgt_always, #always )

		for _ = 1, to_convert do
			local card = always[ #always - _ + 1 ]

			set_comp_value( card, 'ItemComponent', nil, {
				permanently_attached = false,
			}, nil, nil )
		end

		new_always = cur_always - to_convert
	end

	---@type number[]
	local cur_non_always = { }

	for _, card in ipairs( get_all_child( wand ) ) do
		local is_always = get_comp_value( card, 'ItemComponent', nil, {
			{ 'permanently_attached', false },
		}, nil )

		if ( not is_always ) then
			table.insert( cur_non_always, card )
		end
	end

	local excess = #cur_non_always - tgt_real_cap

	if ( excess > 0 ) then
		local x, y = EntityGetTransform( wand )

		---@type number[]
		local real_spell = { }

		for _ = 1, excess, 1 do
			table.insert( real_spell, cur_non_always[ #cur_non_always - _ + 1 ] )
		end
info_print( real_spell, 'adjusts spells - real_spell' )
		rem_child( real_spell, x, y )

		set_comp_value( real_spell, nil, 'enabled_in_world', {
			_enabled = true,
		}, nil, nil )
	end

	return new_always
end

---调整法杖容量
---@param wand number|number[]
---@param cap_change table<string, number?> --属性: always_set, always_delta, real_set, real_delta
function adjust_wand_deck( wand, cap_change )
	if ( type( wand ) == 'number' ) then
		wand = { wand }
	end

	for _, entity in ipairs( wand ) do
		if EntityHasTag( entity, 'wand' ) then
			local always, real_cap = get_always( entity ), get_real_cap( entity )

			local tar_always, tar_real_cap = always, real_cap

			if ( is_not_nan_num( cap_change.always_set ) ) then
				tar_always = cap_change.always_set
			elseif ( is_not_0_num( cap_change.always_delta ) ) then
				tar_always = always + cap_change.always_delta
			end

			if ( is_not_nan_num( cap_change.real_set ) ) then
				tar_real_cap = cap_change.real_set
			elseif ( is_not_0_num( cap_change.real_delta ) ) then
				tar_real_cap = real_cap + cap_change.real_delta
			end

			tar_always, tar_real_cap = math.max( tar_always, 0 ), math.max( tar_real_cap, 0 )

			local actual_always = adjusts_spells( entity, tar_real_cap, tar_always )

			local deck_cap = tar_real_cap + actual_always

			set_comp_obj_value( entity, 'AbilityComponent', nil, {
				{ 'gun_config', 'deck_capacity', deck_cap },
			} )
		end
	end
end

---发射投射物
---@param from number|nil
---@param xml string
---@param x number?
---@param y number?
---@param vel_x number?
---@param vel_y number?
---@param tag string?
---@param func_pre function?
---@param func_aft function?
---@return number shoot_entity
function shoot_proj( from, xml, x, y, vel_x, vel_y, tag, func_pre, func_aft )
	from, x, y, vel_x, vel_y = from or 0, x or 0, y or 0, vel_x or 0, vel_y or 0

	local e, shooter, herd = EntityLoad( xml, x, y ), nil, nil

	if ( from ~= NULL_ENTITY ) then
		if ( is_has_comp( from, 'ProjectileComponent', nil ) ) then
			shooter, herd = get_comp_value( from, 'ProjectileComponent', nil, {
				{ 'mWhoShot', 0 },
				{ 'mShooterHerdId', 0 },
			}, nil )

			set_comp_value( from, 'ProjectileComponent', nil, {
				mEntityThatShot = e,
			}, nil, nil )

			if ( is_has_comp( e, 'ProjectileComponent', nil ) ) then
				set_comp_value( e, 'ProjectileComponent', nil, {
					mWhoShot = shooter,
					mShooterHerdId = herd,
				}, nil, nil )

				if ( EntityHasTag( from, 'friendly_fire_enabled' ) ) then
					EntityAddTag( e, 'friendly_fire_enabled' )

					set_comp_value( e, 'ProjectileComponent', nil, {
						friendly_fire = true,
						collide_with_shooter_frames = 6,
					}, nil, nil )
				end
			end
		end

		if ( not is_not_0_num( shooter ) ) then
			shooter = from
		end
	end

	if ( is_not_nil_str( tag ) ) then
		EntityAddTag( e, tag or '' )
	end

	if ( func_pre ~= nil ) then
		func_pre( from, e, x, y, vel_x, vel_y, tag )
	end

	GameShootProjectile( shooter or 0, x, y, x + vel_x, y + vel_y, e, true, from or 0 )

	set_vel( e, vel_x, vel_y )

	if ( func_aft ~= nil ) then
		func_aft( from, e, x, y, vel_x, vel_y, tag )
	end

	return e
end

---检查 str 是否表示 16 进制数
---@param str string|number
---@return boolean is_hex
local function is_hex( str )
	if ( type( str ) ~= 'string' ) then
		return false
	end

	return #str > 2 and string.sub( str, 1, 2 ) == '0x' and ( not string.match( string.sub( str, 3 ), '[^0-9a-f]' ) )
end

---检查 str 是否表示 10 进制数
---@param str string|number
---@return boolean is_dec
local function is_dec( str )
	if ( type( str ) ~= 'string' ) then
		return false
	end

	return #str > 0 and ( ( str == '0' ) or ( string.sub( str, 1, 1 ) ~= '0' and not string.match( str, '[^0-9]' ) ) )
end

---检查 str 是否表示 8 进制数
---@param str string|number
---@return boolean is_oct
local function is_oct( str )
	if ( type( str ) ~= 'string' ) then
		return false
	end

	return #str > 1 and string.sub( str, 1, 1 ) == '0' and ( not string.match( str, '[^0-7]' ) )
end

---检测这是否是数
---@param str string|number
---@return boolean is_num
function is_num( str )
	if ( type( str ) == 'number' ) then
		return true
	end

	return is_hex( str ) or is_dec( str ) or is_oct( str )
end

---将 str 转换为对应的数值, 能自动检测是表示 16 · 10 · 8 进制数值的字符串;
---不是表示这三种进制数值的字符串则返回nil
---@param str string|number
---@return number|nil
function number_handler( str )
	if type( str ) == 'number' then
		return str
	end
	if type( str ) ~= 'string' then
		return nil
	end

	local is_negative = false
	local str_pure = str
	if ( string.sub( str_pure, 1, 1 ) == '-' ) then
		is_negative = true
		str_pure = string.sub( str_pure, 2, #str_pure )
	end

	local result = nil
	if ( is_num( str ) ) then
		if ( is_hex( str_pure ) ) then
			result = tonumber( str_pure, 16 )
		elseif ( is_dec( str_pure ) ) then
			result = tonumber( str_pure, 10 )
		elseif ( is_oct( str_pure ) ) then
			result = tonumber( str_pure, 8 )
		end
	else
		return nil
	end

	if ( result ) then
		if ( is_negative ) then
			return -result
		else
			return result
		end
	else
		return nil
	end
end

---解析键值对字符串（智能处理值中的逗号、括号和引号）
---@param str string 解析字符串
---@param remove_quotes boolean|nil 是否去除引号包裹
---@return table result_table
function parse_kv_pairs( str, remove_quotes )
	local result, cur_k, cur_v = { }, '', ''
	local in_value, paren_depth, in_quote = false, 0, false

	for i = 1, #str do
		local char = string.sub( str, i, i )

		if ( not in_value ) then
			if ( char == '=' ) then
				in_value = true
				cur_v = ''
			elseif ( char == ',' ) then
				cur_k = ''
			else
				cur_k = cur_k .. char
			end
		else
			if ( char == '\'' and not in_quote ) then
				in_quote = true
				cur_v = cur_v .. char
			elseif ( char == '\'' and in_quote ) then
				in_quote = false
				cur_v = cur_v .. char
			elseif ( in_quote ) then
				cur_v = cur_v .. char
			elseif ( char == '(' ) then
				paren_depth = paren_depth + 1
				cur_v = cur_v .. char
			elseif ( char == ')' ) then
				paren_depth = paren_depth - 1
				cur_v = cur_v .. char
			elseif ( char == ',' and paren_depth == 0 ) then
				if ( #cur_k > 0 ) then
					local final_value = cur_v

					if ( remove_quotes and string.sub( cur_v, 1, 1 ) == '\'' and string.sub( cur_v, -1 ) == '\'' ) then
						final_value = string.sub( cur_v, 2, -2 )
					end

					result[ cur_k ] = final_value
				end

				cur_k, cur_v, in_value = '', '', false
			else
				cur_v = cur_v .. char
			end
		end
	end

	if ( in_value and #cur_k > 0 ) then
		local final_value = cur_v

		if ( remove_quotes and string.sub( cur_v, 1, 1 ) == '\'' and string.sub( cur_v, -1 ) == '\'' ) then
			final_value = string.sub( cur_v, 2, -2 )
		end

		result[ cur_k ] = final_value
	end

	return result
end

---将 values 转换为被 pattern 严格闭合的格式化字符串
---@param values table
---@param pattern string
---@return string formatted_str
function trans_table_to_format( values, pattern )
	if type( values ) ~= 'table' or type( pattern ) ~= 'string' then
		return ''
	end

	local result_parts = { }

	for key, value in pairs( values ) do
		local value_string = tostring( value )
		if ( string.find( value_string, ',' ) or string.find( value_string, '=' ) ) then
			value_string = '\'' .. value_string .. '\''
		end
		table.insert( result_parts, key .. '=' .. value_string )
	end

	return pattern .. table.concat( result_parts, ',' ) .. pattern
end

---从 str 内搜索被 pattern 严格闭合的 id 键值为指定 id 的表，返回搜索到的第 1 个表
---@param str string
---@param id string
---@param pattern string
---@return table|nil result_table
function search_table_from_format( str, id, pattern )
	if type( str ) ~= 'string' or type( id ) ~= 'string' or type( pattern ) ~= 'string' then
		return nil
	end

	local result = nil
	local pos = 1
	local len = #str
	local pattern_len = #pattern

	while ( pos <= len ) do
		local start_pos = string.find( str, pattern, pos, true )
		if ( not start_pos ) then
			break
		end

		local search_end_pos = start_pos + pattern_len
		local end_pos = string.find( str, pattern, search_end_pos, true )
		if ( not end_pos ) then
			break
		end

		local content = string.sub( str, start_pos + pattern_len, end_pos - 1 )

		local id_str = 'id=' .. id
		local id_pos = string.find( content, id_str, 1, true )

		if ( id_pos ) then
			local before_char = ( id_pos == 1 ) and ',' or string.sub( content, id_pos - 1, id_pos - 1 )
			local after_id_end = id_pos + #id_str - 1
			local after_char = ( after_id_end == #content ) and ',' or string.sub( content, after_id_end + 1, after_id_end + 1 )

			local valid_before = ( id_pos == 1 ) or ( before_char == ',' )
			local valid_after = ( after_char == ',' ) or ( after_id_end == #content )

			if valid_before and valid_after then
				result = { }
				local kv_start = 1

				while ( kv_start <= #content ) do
					local eq_pos = string.find( content, '=', kv_start, true )
					if ( not eq_pos ) then
						break
					end

					local key = string.sub( content, kv_start, eq_pos - 1 )
					local value_start = eq_pos + 1
					local value = ''

					if ( value_start <= #content ) then
						local first_char = string.sub( content, value_start, value_start )
						if ( first_char == '(' ) then
							local paren_depth = 1
							local pos = value_start + 1
							while ( pos <= #content and paren_depth > 0 ) do
								local char = string.sub( content, pos, pos )
								if ( char == '(' ) then
									paren_depth = paren_depth + 1
								elseif ( char == ')' ) then
									paren_depth = paren_depth - 1
								end
								pos = pos + 1
							end
							local comma_pos = string.find( content, ',', pos - 1, true )
							local value_end = comma_pos or ( #content + 1 )
							value = string.sub( content, value_start, value_end - 1 )
							kv_start = value_end
						elseif ( first_char == '\'' ) then
							local quote_end = string.find( content, '\'', value_start + 1, true )
							if ( quote_end ) then
								local comma_pos = string.find( content, ',', quote_end + 1, true )
								local value_end = comma_pos or ( #content + 1 )
								value = string.sub( content, value_start + 1, quote_end - 1 )
								kv_start = value_end
							else
								value = string.sub( content, value_start + 1 )
								kv_start = #content + 1
							end
						else
							local comma_pos = string.find( content, ',', eq_pos + 1, true )
							local value_end = comma_pos or ( #content + 1 )
							value = string.sub( content, eq_pos + 1, value_end - 1 )
							kv_start = value_end
						end
					end

					result[ key ] = value
					kv_start = kv_start + 1
				end

				if ( result.id == id ) then
					break
				else
					result = nil
				end
			end
		end

		pos = end_pos + pattern_len
	end

	return result
end

---@param str string 原始字符串
---@param id string 要合并的 id
---@param values table 需要合并的键值对
---@param pattern string 边界标记
---@return string str_merged 合并后的字符串
function merge_str_table_by_id( str, id, values, pattern )
	if ( type( str ) ~= 'string' or type( id ) ~= 'string' or type( values ) ~= 'table' or type( pattern ) ~= 'string' ) then
		return str
	end

	local result = str
	local pos = 1
	local len = #result
	local pattern_len = #pattern

	while ( pos <= len ) do
		local start_pos = string.find( result, pattern, pos, true )
		if ( not start_pos ) then
			break
		end

		local search_end_pos = start_pos + pattern_len
		local end_pos = string.find( result, pattern, search_end_pos, true )
		if ( not end_pos ) then
			break
		end

		local content = string.sub( result, start_pos + pattern_len, end_pos - 1 )

		local id_str = 'id=' .. id
		local id_pos = string.find( content, id_str, 1, true )

		if ( id_pos ) then
			local before_char = ( id_pos == 1 ) and ',' or string.sub( content, id_pos - 1, id_pos - 1 )
			local after_id_end = id_pos + #id_str - 1
			local after_char = ( after_id_end == #content ) and ',' or string.sub( content, after_id_end + 1, after_id_end + 1 )

			local valid_before = ( id_pos == 1 ) or ( before_char == ',' )
			local valid_after = ( after_char == ',' ) or ( after_id_end == #content )

			if ( valid_before and valid_after ) then
				local original_table = { }
				local kv_start = 1

				while ( kv_start <= #content ) do
					local eq_pos = string.find( content, '=', kv_start, true )
					if ( not eq_pos ) then
						break
					end

					local key = string.sub( content, kv_start, eq_pos - 1 )
					local value_start = eq_pos + 1
					local value = ''

					if ( value_start <= #content ) then
						local first_char = string.sub( content, value_start, value_start )
						if ( first_char == '(' ) then
							local paren_depth = 1
							local p = value_start + 1
							while ( p <= #content and paren_depth > 0 ) do
								local char = string.sub( content, p, p )
								if ( char == '(' ) then
									paren_depth = paren_depth + 1
								elseif ( char == ')' ) then
									paren_depth = paren_depth - 1
								end
								p = p + 1
							end
							local comma_pos = string.find( content, ',', p - 1, true )
							local value_end = comma_pos or ( #content + 1 )
							value = string.sub( content, value_start, value_end - 1 )
							kv_start = value_end
						elseif ( first_char == '\'' ) then
							local quote_end = string.find( content, '\'', value_start + 1, true )
							if ( quote_end ) then
								local comma_pos = string.find( content, ',', quote_end + 1, true )
								local value_end = comma_pos or ( #content + 1 )
								value = string.sub( content, value_start + 1, quote_end - 1 )
								kv_start = value_end
							else
								value = string.sub( content, value_start + 1 )
								kv_start = #content + 1
							end
						else
							local comma_pos = string.find( content, ',', eq_pos + 1, true )
							local value_end = comma_pos or ( #content + 1 )
							value = string.sub( content, eq_pos + 1, value_end - 1 )
							kv_start = value_end
						end
					end

					original_table[ key ] = value
					kv_start = kv_start + 1
				end

				for key, new_value in pairs( values ) do
					if ( key ~= 'id' ) then
						local old_value = original_table[ key ]
						if ( old_value ) then
							local old_num = number_handler( old_value )
							local new_num = number_handler( new_value )
							if ( old_num and new_num ) then
								original_table[ key ] = tostring( old_num + new_num )
							else
								original_table[ key ] = tostring( new_value )
							end
						else
							original_table[ key ] = tostring( new_value )
						end
					end
				end

				local new_kv_parts = { }

				for key, value in pairs( original_table ) do
					local value_string = tostring( value )
					if ( string.find( value_string, ',' ) or string.find( value_string, '=' ) ) then
						value_string = '\'' .. value_string .. '\''
					end
					table.insert( new_kv_parts, key .. '=' .. value_string )
				end

				local new_content = table.concat( new_kv_parts, ',' )
				local new_block = pattern .. new_content .. pattern

				result = string.sub( result, 1, start_pos - 1 ) .. new_block .. string.sub( result, end_pos + pattern_len )

				len = #result
				pos = start_pos + #new_block
			else
				pos = end_pos + pattern_len
			end
		else
			pos = end_pos + pattern_len
		end
	end

	return result
end

---将 str 内被 pattern 严格闭合的 id 键值为指定 id 的表替换为 values 中的值，返回修改后的字符串
---@param str string
---@param id string
---@param values table
---@param pattern string
---@return string str_replaced
function replace_str_table_by_id( str, id, values, pattern )
	if type( str ) ~= 'string' or type( id ) ~= 'string' or type( values ) ~= 'table' or type( pattern ) ~= 'string' then
		return str
	end

	local result = str
	local pos = 1
	local len = #result
	local pattern_len = #pattern

	while ( pos <= len ) do
		local start_pos = string.find( result, pattern, pos, true )
		if ( not start_pos ) then
			break
		end

		local search_end_pos = start_pos + pattern_len
		local end_pos = string.find( result, pattern, search_end_pos, true )
		if ( not end_pos ) then
			break
		end

		local content = string.sub( result, start_pos + pattern_len, end_pos - 1 )

		local id_str = 'id=' .. id
		local id_pos = string.find( content, id_str, 1, true )

		if ( id_pos ) then
			local before_char = ( id_pos == 1 ) and ',' or string.sub( content, id_pos - 1, id_pos - 1 )
			local after_id_end = id_pos + #id_str - 1
			local after_char = ( after_id_end == #content ) or string.sub( content, after_id_end + 1, after_id_end + 1 )

			local valid_before = ( id_pos == 1 ) or ( before_char == ',' )
			local valid_after = ( after_char == ',' ) or ( after_id_end == #content )

			if ( valid_before and valid_after ) then
				local new_kv_parts = { }
				for key, value in pairs( values ) do
					table.insert( new_kv_parts, key .. '=' .. tostring( value ) )
				end
				local new_content = table.concat( new_kv_parts, ',' )
				local new_block = pattern .. new_content .. pattern

				result = string.sub( result, 1, start_pos - 1 ) .. new_block .. string.sub( result, end_pos + pattern_len )

				len = #result
				pos = start_pos + #new_block
			else
				pos = end_pos + pattern_len
			end
		else
			pos = end_pos + pattern_len
		end
	end

	return result
end

---在不完全替换的情况下更新块内容, 为键传入 nil 改为删除键
---@param str string
---@param id string
---@param updates table
---@param pattern string
---@return string str_updated
function update_str_table_by_id( str, id, updates, pattern )
	if ( type( str ) ~= 'string' or type( id ) ~= 'string' or type( updates ) ~= 'table' or type( pattern ) ~= 'string' ) then
		return str
	end

	local result = str
	local pos = 1
	local len = #result
	local pattern_len = #pattern

	while ( pos <= len ) do
		local start_pos = string.find( result, pattern, pos, true )
		if ( not start_pos ) then
			break
		end

		local search_end_pos = start_pos + pattern_len
		local end_pos = string.find( result, pattern, search_end_pos, true )
		if ( not end_pos ) then
			break
		end

		local content = string.sub( result, start_pos + pattern_len, end_pos - 1 )

		local id_str = 'id=' .. id
		local id_pos = string.find( content, id_str, 1, true )

		if ( id_pos ) then
			local before_char = ( id_pos == 1 ) and ',' or string.sub( content, id_pos - 1, id_pos - 1 )
			local after_id_end = id_pos + #id_str - 1
			local after_char = ( after_id_end == #content ) or string.sub( content, after_id_end + 1, after_id_end + 1 )

			local valid_before = ( id_pos == 1 ) or ( before_char == ',' )
			local valid_after = ( after_char == ',' ) or ( after_id_end == #content )

			if ( valid_before and valid_after ) then
				local original_table = { }
				local kv_start = 1

				while ( kv_start <= #content ) do
					local eq_pos = string.find( content, '=', kv_start, true )
					if ( not eq_pos ) then
						break
					end

					local key = string.sub( content, kv_start, eq_pos - 1 )
					local value_start = eq_pos + 1
					local value = ''

					if ( value_start <= #content ) then
						local first_char = string.sub(content, value_start, value_start )
						if ( first_char == '(' ) then
							local paren_depth = 1
							local p = value_start + 1
							while ( p <= #content and paren_depth > 0 ) do
								local char = string.sub( content, p, p )
								if ( char == '(' ) then
									paren_depth = paren_depth + 1
								elseif ( char == ')' ) then
									paren_depth = paren_depth - 1
								end
								p = p + 1
							end
							local comma_pos = string.find( content, ',', p - 1, true )
							local value_end = comma_pos or ( #content + 1 )
							value = string.sub( content, value_start, value_end - 1 )
							kv_start = value_end
						elseif ( first_char == '\'' ) then
							local quote_end = string.find( content, '\'', value_start + 1, true )
							if ( quote_end ) then
								local comma_pos = string.find( content, ',', quote_end + 1, true )
								local value_end = comma_pos or ( #content + 1 )
								value = string.sub( content, value_start + 1, quote_end - 1 )
								kv_start = value_end
							else
								value = string.sub( content, value_start + 1 )
								kv_start = #content + 1
							end
						else
							local comma_pos = string.find( content, ',', eq_pos + 1, true )
							local value_end = comma_pos or ( #content + 1 )
							value = string.sub( content, eq_pos + 1, value_end - 1 )
							kv_start = value_end
						end
					end

					original_table[key] = value
					kv_start = kv_start + 1
				end

				for key, new_value in pairs( updates ) do
					if ( new_value == nil ) then
						original_table[ key ] = nil
					else
						original_table[ key ] = tostring( new_value )
					end
				end

				local kv_pair = { }
				for k, v in pairs( original_table ) do
					local v_str = tostring( v )
					if ( string.find( v_str, ',' ) or string.find( v_str, '=' ) ) then
						v_str = '\'' .. v_str .. '\''
					end
					table.insert( kv_pair, k .. '=' .. v_str )
				end
				local new_content = table.concat( kv_pair, ',' )
				local new_block = pattern .. new_content .. pattern

				result = string.sub( result, 1, start_pos - 1 ) .. new_block .. string.sub( result, end_pos + pattern_len )

				len = #result
				pos = start_pos + #new_block
			else
				pos = end_pos + pattern_len
			end
		else
			pos = end_pos + pattern_len
		end
	end

	return result
end

---从 str 内删除被 pattern 严格闭合的 id 键值为指定 id 的前 count 个表，返回修改后的字符串
---@param str string
---@param id string
---@param count number
---@param pattern string
---@return string str_deleted
function delete_table_format( str, id, count, pattern )
	if type( str ) ~= 'string' or type( id ) ~= 'string' or type( count ) ~= 'number' or type( pattern ) ~= 'string' then
		return str
	end

	local result = str
	local deleted_count = 0
	local delete_all = ( count == -1 )
	local pos = 1
	local len = #result
	local pattern_len = #pattern

	while ( pos <= len and ( delete_all or deleted_count < count ) ) do
		local start_pos = string.find( result, pattern, pos, true )
		if ( not start_pos ) then
			break
		end

		local search_end_pos = start_pos + pattern_len
		local end_pos = string.find( result, pattern, search_end_pos, true )
		if ( not end_pos ) then
			break
		end

		local content = string.sub( result, start_pos + pattern_len, end_pos - 1 )

		local id_str = 'id=' .. id
		local id_pos = string.find( content, id_str, 1, true )

		if ( id_pos ) then
			local before_char = ( id_pos == 1 ) and ',' or string.sub( content, id_pos - 1, id_pos - 1 )
			local after_id_end = id_pos + #id_str - 1
			local after_char = ( after_id_end == #content ) or string.sub( content, after_id_end + 1, after_id_end + 1 )

			local valid_before = ( id_pos == 1) or ( before_char == ',' )
			local valid_after = ( after_char == ',') or ( after_id_end == #content )

			if valid_before and valid_after then
				result = string.sub( result, 1, start_pos - 1 ) .. string.sub( result, end_pos + pattern_len )
				deleted_count = deleted_count + 1

				len = #result
				pos = start_pos
			else
				pos = end_pos + pattern_len
			end
		else
			pos = end_pos + pattern_len
		end
	end

	return result
end

---为 c.action_description 新增 args;
---可替换或叠加
---@param c table
---@param options table
---@param args table|nil
---@param extra_entities string|nil
---@param pattern string
function add_desc_by_info( c, options, args, extra_entities, pattern )
	if ( not reflecting and args ) then
		local prefix = '::__DELAY_EXP__::'
		for i, _ in pairs( args ) do
			if ( type( _ ) == 'string' ) then
				local pos = string.find( _, prefix, 1, true )

				if ( pos == 1 ) then
					args[ i ] = string.sub( _, #prefix + 1 )
				end
			end
		end

		local desc = c.action_description or ''
		local values = search_table_from_format( desc, args.id, pattern )

		if ( values and options.replace ) then
			local str = nil

			if ( options.update ) then
				str = update_str_table_by_id( desc, args.id, args, pattern )
			elseif ( options.merge ) then
				str = merge_str_table_by_id( desc, args.id, args, pattern )
			else
				str = replace_str_table_by_id( desc, args.id, args, pattern )
			end

			c.action_description = str
		else
			c.action_description = desc .. trans_table_to_format( args, pattern )

			if ( extra_entities ) then
				c.extra_entities = ( c.extra_entities or '' ) .. extra_entities
			end
		end
	end
end

---解析 command 的参数并求值
---@param action string
---@param entity number
---@param param_names string[]
---@param pattern string?
---@return table|nil result_table
function parse_and_evaluate_command_paras( action, entity, param_names, pattern )
	local p_comp = EntityGetFirstComponent( entity, 'ProjectileComponent' )

	if ( not p_comp ) then
		return nil
	end

	local desc = ComponentObjectGetValue2( p_comp, 'config', 'action_description' )
	local values = search_table_from_format( desc, action, pattern or '$' )

	if ( not values ) then
		return nil
	end

	local shooter = tonumber( values.shooter ) or 0
	local x, y = EntityGetTransform( entity )

	local res = { }

	res.shooter = shooter

	for _, param_name in ipairs( param_names ) do
		local raw_value = values[ param_name ]

		if ( raw_value ~= nil ) then
			if ( string.find( raw_value, '@', 1, true ) or string.find( raw_value, '~', 1, true ) or string.find( raw_value, '(', 1, true ) ) then
				local result, is_correct = evaluate_delayed_expression( raw_value, '#', shooter, x, y )

				if ( is_correct and result ~= nil ) then
					res[ param_name ] = result
				end
			else
				local num = tonumber( raw_value )

				if ( num ~= nil ) then
					res[ param_name ] = num
				end
			end
		end
	end

	return res
end
