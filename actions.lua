--actions

function make_action(_type,args)
 local o={type=_type}
 if args then
  for k,v in pairs(args) do
  o[k]=v
  end
 end
 
 --define perform method according to type
 if _type=="move" then
  o.perform=function(self,gamemap,entity)
   --check if move is valid
   local dest_x,dest_y=entity.x+self.dx,entity.y+self.dy
   if (not gamemap:in_bounds(dest_x,dest_y)) return
   if (not gamemap:get_tile(dest_x,dest_y).walkable) return
   if (gamemap:get_blocking_entity_at(dest_x,dest_y)) return

   entity:move(self.dx,self.dy)
  end
 elseif _type=="melee" then
  o.perform=function(self,gamemap,entity)
   local dest_x,dest_y=entity.x+self.dx,entity.y+self.dy
   local target=gamemap:get_blocking_entity_at(dest_x,dest_y)
   if (not target) return
   --debug
   sfx(sound.bump)
  end
 elseif _type=="bump" then
  o.perform=function(self,gamemap,entity)  
   local dest_x,dest_y=entity.x+self.dx,entity.y+self.dy
   if (gamemap:get_blocking_entity_at(dest_x,dest_y)) return make_action("melee",{dx=self.dx,dy=self.dy}):perform(gamemap,entity)
   return make_action("move",{dx=self.dx,dy=self.dy}):perform(gamemap,entity)
  end
 end
 return o
end

--input handler
function handle_input()
 local action
 if btnp(⬆️) then
  action=make_action("bump",{dx=0,dy=-1})
 end
 if btnp(⬇️) then
  action=make_action("bump",{dx=0,dy=1})
 end
 if btnp(⬅️) then
  action = make_action("bump",{dx=-1,dy=0})
 end
 if btnp(➡️) then
  action = make_action("bump",{dx=1,dy=0})
 end
 return action
end
