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