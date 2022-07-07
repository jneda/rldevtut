--map related

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