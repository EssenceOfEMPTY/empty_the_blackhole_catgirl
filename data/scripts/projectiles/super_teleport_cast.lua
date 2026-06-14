dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

local proj = get_root_entity( )
local px, py = EntityGetTransform( proj )

local vel_x, vel_y = get_vel( proj )

local angle = -atan( vel_y, vel_x )

local end_x = px + math.cos( angle ) * 120
local end_y = py - math.sin( angle ) * 120

local success, ex, ey = RaytracePlatforms( px, py, end_x, end_y )

if ( not success ) then
	ex, ey = end_x, end_y
end

tp( proj, ex, ey )
