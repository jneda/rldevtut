--fov
--recursive shadowcasting
--https://www.lexaloffle.com/bbs/?pid=73376

function do_fov(x,y,radius)
 gamemap.visible={}
 if (not gamemap.visible[x]) gamemap.visible[x] = {}
 if (not gamemap.explored[x]) gamemap.explored[x] = {}
 gamemap.visible[x][y] = true
 gamemap.explored[x][y] = true
 local point={x=x,y=y}
 for octant=0,7 do
  fov(point,1,0,1,octant,radius)
 end
end

function fov(point,distance,low_slope,hi_slope,octant,radius)
 --[[
 distance, height from player position to map xy
 flips/transposes per octant
 --]]
 function dhtoxy(distance,height)
  local x,y=point.x,point.y
  if (octant&0x1>0) distance=-distance
  if (octant&0x2>0) height=-height
  if (octant&0x4>0) return x+height,y+distance
  return x+distance,y+height
 end

 if (distance>radius) return

 local map_x,map_y,low,hi,in_gap
 low=flr(low_slope*distance+0.5)
 hi=flr(hi_slope*distance+0.5)

 for current_height=low,hi do
  map_x,map_y=dhtoxy(distance,current_height)

  if (dist_to(point.x,point.y,map_x,map_y)<radius) then
   if (not gamemap.visible[map_x]) gamemap.visible[map_x] = {}
   if (not gamemap.explored[map_x]) gamemap.explored[map_x] = {}
   gamemap.visible[map_x][map_y]=true
   gamemap.explored[map_x][map_y]=true
  end

  if is_opaque(map_x,map_y) then
   if in_gap then
    --reached end of gap
    fov(point,distance+1,low_slope,(current_height-0.5)/distance,octant,radius)
   end
   low_slope=(current_height+0.5)/distance
   in_gap=false
  else
   in_gap=true
   if (current_height==hi) fov(point,distance+1,low_slope,hi_slope,octant,radius)
  end
 end
end

function dist_to(x1,y1,x2,y2)
 local dx,dy=x1-x2,y1-y2
 return sqrt(dx*dx+dy*dy)
end

function is_opaque(x,y)
 if (gamemap.tiles[x][y]!=wall) return false
 return true
end
