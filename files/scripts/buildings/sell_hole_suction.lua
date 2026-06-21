dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )
dofile_once( 'data/scripts/gun/gun_actions.lua' )

local sell_hole, coin = get_root_entity( ), 0
local x, y = EntityGetTransform( sell_hole )

local suck_wand = EntityGetInRadiusWithTag( x, y, 128, 'wand' )
local suck_card = EntityGetInRadiusWithTag( x, y, 128, 'card_action' )

local move = { }

for i, _ in ipairs( suck_wand ) do
	if ( not ( is_child( _ ) or is_has_comp( _, 'ItemCostComponent' ) ) ) then
		local ix, iy = EntityGetTransform( _ )

		if ( sqrt_p2_add( x - ix, y - iy ) < 8 ) then
			local sell_num = math.floor( math.abs( y / 1000 ) )
			local sell_fact = math.max( sell_num, 1.5 ) ^ 2

			local wand_lvl = math.max( sell_num ^ 2 - 1, 0 )

			coin = 50 + wand_lvl * 120

			local childs = get_all_child( _, nil, nil )

			for j, child in ipairs( childs ) do
				set_comp_value( child, 'ItemActionComponent', nil, nil, nil, function ( comp )
					local action = ComponentGetValue2( comp, 'action_id' )

					for k, act in ipairs( actions ) do
						if ( act.id == action ) then
							coin = coin + math.max( ( act.price * 0.5 + sell_fact * 70 ), 10 )

							break
						end
					end
				end )
			end

			EntityKill( _ )
		else
			local vel_x, vel_y = get_vel( _ )

			local dist = sqrt_p2_add( x - ix, y - iy )
			local angle = atan( y - iy, x - ix )

			set_vel( _, vel_x + math.cos( angle ) * ( 50 - dist ) / 2, vel_y + math.sin( angle ) * ( 50 - dist ) / 2 )
		end
	end
end

for i, _ in ipairs( suck_card ) do
	if ( not ( is_child( _ ) or is_has_comp( _, 'ItemCostComponent' ) ) ) then
		local ix, iy = EntityGetTransform( _ )

		if ( sqrt_p2_add( x - ix, y - iy ) < 8 ) then
			local sell_num = math.floor( math.abs( y / 1000 ) )
			local sell_fact = math.max( sell_num, 1.5 ) ^ 2

			if ( EntityHasTag( _, 'card_action' ) ) then
				set_comp_value( _, 'ItemActionComponent', nil, nil, nil, function ( comp )
					local action = ComponentGetValue2( comp, 'action_id' )

					for k, act in ipairs( actions ) do
						if ( act.id == action ) then
							coin = coin + math.max( ( act.price * 0.5 + sell_fact * 70 ), 10 )

							EntityKill( _ )

							break
						end
					end
				end )
			end
		else
			local vel_x, vel_y = get_vel( _ )

			local dist = sqrt_p2_add( x - ix, y - iy )
			local angle = atan( y - iy, x - ix )

			set_vel( _, vel_x + math.cos( angle ) * ( 50 - dist ) / 2, vel_y + math.sin( angle ) * ( 50 - dist ) / 2 )
		end
	end
end

if ( coin > 0 ) then
	create_gold( x, y, coin, false )

	if ( coin > 750 ) then
		shoot_proj( sell_hole, 'data/entities/particles/gold_pickup_huge.xml', x, y, 0, 0, nil, nil, nil )
	elseif ( coin > 125 ) then
		shoot_proj( sell_hole, 'data/entities/particles/gold_pickup_large.xml', x, y, 0, 0, nil, nil, nil )
	else
		shoot_proj( sell_hole, 'data/entities/particles/gold_pickup.xml', x, y, 0, 0, nil, nil, nil )
	end

	set_comp_value( sell_hole, 'SpriteComponent', nil, {
		rect_animation = 'flash',
		next_rect_animation = 'loop',
	}, nil )
end

for i, _ in ipairs( move ) do
	
end
