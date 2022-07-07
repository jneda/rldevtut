--main functions

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
	
	gamemap=generate_dungeon(map_width,map_height)

	debug_msg=""
end

function _update()
	action=handle_input()
	if action then
		if action.type=="move" then
		 --invoke method
		 action:perform(gamemap,player)
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