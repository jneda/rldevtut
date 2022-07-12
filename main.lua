--main functions

function _init()
 screen_width=128
 screen_height=128

 char_width=4
 char_height=6
 
 map_width=flr(screen_width/char_width)
 map_height=flr(screen_height/char_height)

 room_max_size=8
 room_min_size=4
 max_rooms=20
 
 player_x=flr(map_width/2)
 player_y=flr(map_height/2)
 
 player=make_entity(player_x,player_y,"@",7)
 npc=make_entity(player_x-5,player_y,"@",10)
 entities={npc,player}
 
 gamemap=generate_dungeon(
  max_rooms,
  room_min_size,
  room_max_size,
  map_width,
  map_height,
  player
 )

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
 
 gamemap:draw()
 
 for entity in all(entities) do
  print(
   entity.char,
   entity.x*char_width,
   entity.y*char_height,
   entity.col
  )
 end

 print(debug_msg,0,0,3)
end