--entities

function make_entity(x,y,char,col,name,blocks_movement)
 local o={
  x=x,y=y,char=char,col=col,name=name,blocks_movement=blocks_movement
 }

 o.spawn=function(self,gamemap,x,y)
  local clone={}
  for key,value in pairs(self) do
   clone[key]=value
  end
  clone.x=x
  clone.y=y
  add(gamemap.entities,clone)
  return clone
 end

 o.move=function (self,dx,dy)
  self.x+=dx
  self.y+=dy
 end
 return o
end

--factories
entity_factories={
 player=make_entity(0,0,"@",7,"player",true),
 orc=make_entity(0,0,"o",11,'orc',true),
 troll=make_entity(0,0,"t",3,"troll",true)
}

--player init
function make_player()
 local player={}
 for key,value in pairs(entity_factories.player) do
  player[key]=value
 end
 return player
end