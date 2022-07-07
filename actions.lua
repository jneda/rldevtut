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
	  local dest_x=entity.x+self.dx
	  local dest_y=entity.y+self.dy
	  if (not gamemap:in_bounds(dest_x,dest_y)) return
	  if (not gamemap:get_tile(dest_x,dest_y).walkable) return
      
	  entity:move(self.dx,self.dy)
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