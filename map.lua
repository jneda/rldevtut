--map related

--tiles
function make_tile(walkable, transparent,dark,light)

 return {
  walkable = walkable,
  transparent = transparent,
  dark=dark,
  light=light
 }
end

shroud={char=" ",fg=0}

floor = make_tile(true, true,{char=".",fg=5},{char=".",fg=6})
wall = make_tile(false, false,{char="#",fg=5},{char="#",fg=6})

--map table
function make_map(width, height)
 local gamemap = {}
 gamemap.width = width
 gamemap.height = height
 gamemap.tiles = map_fill(width, height)
 gamemap.visible = {}
 gamemap.explored = {}

 gamemap.get_tile = function(self, x, y)
  if (not self:in_bounds(x, y)) then
   return nil
  end
  return self.tiles[x][y]
 end

 gamemap.set_tile = function(self,x,y,tile)
  if (not self:in_bounds(x,y)) then
   return
  end
  self.tiles[x][y]=tile
 end

 gamemap.in_bounds = function(self, x, y)
  return x >= 0 and x <= self.width - 1
  and y >= 0 and y <= self.height - 1
 end

 gamemap.draw = function(self)
  for x = 0, self.width - 1 do
   for y = 0, self.height - 1 do    
    local tile = self.tiles[x][y]
    local char,fg
    if self.visible[x] and self.visible[x][y] then
     --add(debug_msgs,"visible@"..x..","..y)
     char=tile.light.char
     fg=tile.light.fg
     --add(debug_msgs, char.."/"..fg)
    elseif self.explored[x] and self.explored[x][y] then
     char=tile.dark.char
     fg=tile.dark.fg
    else
     char=shroud.char
     fg=shroud.fg
    end

    print(char,
     x*char_width,
     y*char_height,
     fg)
   end
  end
 end

 return gamemap
end
