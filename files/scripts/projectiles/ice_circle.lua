dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local entity = get_root_entity( )
local x, y = EntityGetTransform( entity )

local how_many, theta, length = 12, 0, 300
local angle_inc = math_2p / how_many

for _ = 1, how_many do
	local vel_x, vel_y = math.cos( theta ) * length, math.sin( theta ) * length
	local del_x, del_y = normalize( vel_x, vel_y )

	shoot_proj( entity, empty_path .. 'entities/projectiles/ice_circle_projectile.xml', x + 3 * del_x, y + 3 * del_y, vel_x, vel_y, nil, nil, nil )

	theta = theta + angle_inc
end
