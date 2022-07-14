--main functions

function _init()
 sound={bump=0,ponder=1}

 screen_width=128
 screen_height=128

 char_width=4
 char_height=6
 
 map_width=flr(screen_width/char_width)
 map_height=flr(screen_height/char_height)

 room_max_size=flr(map_width/4)
 room_min_size=flr(map_height/4)
 max_rooms=20
 max_monsters_per_room=2

 sight_radius=8
 
 player=make_player()
 
 gamemap=generate_dungeon(
  max_rooms,
  room_min_size,
  room_max_size,
  map_width,
  map_height,
  max_monsters_per_room,
  player
 )

 do_fov(player.x,player.y,sight_radius)

 debug_msgs={}
end

function _update()
 action=handle_input()
 if action then
  action:perform(gamemap,player)
  handle_enemy_turns()
  do_fov(player.x,player.y,sight_radius)
 end
end

function _draw()
 cls() 
 gamemap:draw()
 print_debug()
end

function print_debug()
 for msg in all(debug_msgs) do
  print(msg,3)
 end
end

function handle_enemy_turns()
 for entity in all(gamemap.entities) do
  if not entity.name=="player" then
   sfx(sound.ponder)
  end
 end
end