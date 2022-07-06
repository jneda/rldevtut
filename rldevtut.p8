pico-8 cartridge // http://www.pico-8.com
version 36
__lua__
function _init()
	screen_width=128
	screen_height=128

	tile_size=8
	
	char_offset_x=2
	char_offset_y=1
	
	player_x=screen_width/2
	player_y=screen_height/2
	
	player=make_entity(player_x,player_y,"@",7)
	npc=make_entity(player_x-5*tile_size,player_y,"@",10)
	entities={npc,player}
end

function _update()
	action=handle_input()
	if action then
		if action.type=="move" then
			player:move(action.dx,action.dy)
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
	
	for entity in all(entities) do
		print(
		 entity.char,
		 entity.x+char_offset_x,
		 entity.y+char_offset_y,
		 entity.col
		)
	end
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
 o.move = function (slf,dx,dy)
  slf.x+=dx*tile_size
  slf.y+=dy*tile_size
 end
 return o
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
