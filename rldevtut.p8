pico-8 cartridge // http://www.pico-8.com
version 36
__lua__
--roguelikedev does the complete roguelike tutorial 2022
--by jneda

function _init()
	screen_width=128
	screen_height=128

	tile_size=8
	
	map_width=screen_width/tile_size
	map_height=screen_height/tile_size
	
	char_offset_x=2
	char_offset_y=1
	
	player_x=flr(map_width/2)
	player_y=flr(map_height/2)
	
	player=make_entity(player_x,player_y,"@",7)
	npc=make_entity(player_x-5,player_y,"@",10)
	entities={npc,player}
	
	gamemap=make_map(map_width,map_height)

	debug_msg=""
end

function _update()
	action=handle_input()
	if action then
		if action.type=="move" then
		 local destx=player.x+action.dx
		 local desty=player.y+action.dy
		 --debug
		 debug_msg="dx:"..destx.." dy:"..desty
		 local t=gamemap:get_tile(destx,desty)
		 if t and t.walkable and gamemap:in_bounds(destx,desty)then
			 player:move(action.dx,action.dy)
   end
  end
 end
end

function _draw()
	cls()
	--[[
	--debug lines
	for i=0,15 do
	 --horizontal
	 line(7+i*8,0,7+i*8,127)
	 --vertical
	 line(0,7+i*8,127,7+i*8)
	end
	--]]
	
	gamemap:draw()
	
	for entity in all(entities) do
		print(
		 entity.char,
		 entity.x*tile_size+char_offset_x,
		 entity.y*tile_size+char_offset_y,
		 entity.col
		)
	end

	print(debug_msg,0,0,3)
end
-->8
--actions

function make_action(_type,args)
	local o={type=_type}
	if args then
		for k,v in pairs(args) do
			o[k]=v
		end
	end
	return o
end

--input handler
function handle_input()
	local action
	if(btnp(⬆️)) action=make_action("move",{dx=0,dy=-1})
	if(btnp(⬇️)) action=make_action("move",{dx=0,dy=1})
	if(btnp(⬅️)) action=make_action("move",{dx=-1,dy=0})
	if(btnp(➡️)) action=make_action("move",{dx=1,dy=0})
	return action
end
-->8
--entities

function make_entity(x,y,char,col)
 local o={
  x=x,y=y,char=char,col=col
 }
 o.move = function (self,dx,dy)
  self.x+=dx
  self.y+=dy
 end
 return o
end
-->8
--map

--tiles
function make_tile(ch,fg,bg,
 walkable, transparent)
 
 return {
  ch=ch,fg=fg,bg=bg,
  walkable=walkable,
  transparent=transparent
 }	
end

floor=make_tile(".",6,0,true,true)
wall=make_tile("#",6,0,false,false)

--map table
function make_map(width,height)
	local gamemap={}
	gamemap.width=width
	gamemap.height=height
	gamemap.tiles=mapgen(width,height)
	gamemap.get_tile=function(self,x,y)
	 if (not self:in_bounds(x,y)) return nil
     return self.tiles[x][y]
	end
	gamemap.in_bounds=function(self,x,y)
	 return x>=0 and x<=self.width-1
	  and y>=0 and y<=self.height-1
	end	
	gamemap.draw=function(self)
	 for x=0,self.width-1 do
	 	for y=0,self.height-1 do
	 		local t=self.tiles[x][y]
	 		print(t.ch,
	 		 x*tile_size+char_offset_x,
	 		 y*tile_size+char_offset_y,
	 		 t.fg)
			end
  		end
	end
	
	return gamemap
end

function mapgen(width,height)
 local tiles={}
	for x=0,width-1 do
		local column={}
		for y=0,height-1 do
			local t
			if x>=7 and x<=9 and y==4 then
				t=wall
			else
			 t=floor
			end
			column[y]=t
		end
		tiles[x]=column
	end
	return tiles
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
