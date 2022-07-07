--procedural map generation

--fill map with walls
function map_fill(width, height)
 local tiles = {}
 for x = 0, width - 1 do
  local column = {}
  for y = 0, height - 1 do
   column[y] = wall
  end
  tiles[x] = column
 end
 return tiles
end

--procgen utils
function make_room(x,y,w,h)
 local r={x1=x,y1=y,x2=x+w,y2=y+h}
 local center_x=flr((r.x1+r.x2)/2)
 local center_y=flr((r.y1+r.y2)/2)
 r.center={x=center_x,y=center_y}
 return r
end

function carve_room(gamemap,room)
 for x=room.x1+1,room.x2-1 do
  for y=room.y1+1,room.y2-1 do
   gamemap:set_tile(x,y,floor)
  end
 end
end

function plotline(x1,y1,x2,y2)
--bresenham algorithm:http://members.chello.at/~easyfilter/bresenham.html
 local dx=abs(x2-x1)
 local dy=-abs(y2-y1)
 local sx,sy
 if x1<x2 then sx=1 else sx=-1 end
 if y1<y2 then sy=1 else sy=-1 end
 local err=dx+dy
 local e2

 local points={}
 while(true) do
  add(points,{x=x1,y=y1})
  if x1==x2 and y1==y2 then break end
  e2=2*err
  if e2>=dy then
   err+=dy
   x1+=sx
  end
  if e2<=dx then
   err+=dx
   y1+=sy
  end
 end
 
 return points
end

function carve_tunnel(gamemap,startpoint,endpoint)
local corner_x,corner_y
 if rnd()<0.5 then
  corner_x=endpoint.x
  corner_y=startpoint.y
 else
  corner_x=startpoint.x
  corner_y=endpoint.y
 end
 
 local points={}
 for p in all(plotline(startpoint.x,startpoint.y,corner_x,corner_y)) do
  gamemap:set_tile(p.x,p.y,floor)
 end
 for p in all(plotline(corner_x,corner_y,endpoint.x,endpoint.y)) do
  gamemap:set_tile(p.x,p.y,floor)
 end
end

function generate_dungeon(map_width,map_height)
 local gamemap=make_map(map_width,map_height)

 local room1=make_room(0,0,6,8)
 local room2=make_room(6,4,8,6)

 carve_room(gamemap,room1)
 carve_room(gamemap,room2)

 carve_tunnel(gamemap,room1.center,room2.center)

 return gamemap
end

--[[
--dummy level
function mapgen(width, height)
 local tiles = {}
 for x = 0, width - 1 do
  local column = {}
  for y = 0, height - 1 do
   local t
   if x >= 7 and x <= 9 and y == 4 then
    t = wall
   else
    t = floor
   end
   column[y] = t
  end
  tiles[x] = column
 end
 return tiles
end
]]--