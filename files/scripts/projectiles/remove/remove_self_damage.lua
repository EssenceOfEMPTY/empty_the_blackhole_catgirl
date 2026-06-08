dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local proj = get_root_entity( )

if ( is_has_comp( proj, 'ProjectileComponent', nil ) ) then
	set_comp_value( proj, 'ProjectileComponent', nil, {
		friendly_fire = false,
		collide_with_shooter_frames = -1,
	}, nil, nil )

	local shooter = get_comp_info( proj, 'ProjectileComponent', nil, {
		{ 'mWhoShot', nil },
	}, nil )

	if ( is_not_0_num( shooter ) ) then
		set_comp_obj_value( proj, 'ProjectileComponent', nil, {
			{ 'config_explosion', 'dont_damage_this', shooter },
		}, nil, nil )

		if ( is_has_comp( proj, 'AreaDamageComponent', nil ) ) then
			if ( is_player( shooter ) ) then
				set_comp_value( proj, 'AreaDamageComponent', nil, {
					entities_with_tag = all_tag.enemy,
				}, nil, nil )
			elseif ( is_enemy( shooter ) ) then
				set_comp_value( proj, 'AreaDamageComponent', nil, {
					entities_with_tag = all_tag.player,
				}, nil, nil )
			else
				set_comp_value( proj, 'AreaDamageComponent', nil, {
					entities_with_tag = all_tag.hit,
				}, nil, nil )
			end
		end

		if ( is_has_comp( proj, 'LightningComponent', nil ) ) then
			set_comp_obj_value( proj, 'LightningComponent', nil, {
				{ 'config_explosion', 'dont_damage_this', shooter },
			}, nil, nil )
		end

		if ( is_has_comp( proj, 'LaserEmitterComponent', nil ) ) then
			EntityAddChild( shooter, proj )
		end
	end
end
