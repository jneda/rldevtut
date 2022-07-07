--procedural map generation

function mapgen(width,height)
 local tiles={}
	for x=0,width-1 do
		local column={}
		for y=0,height-1 do
			local t
			if x>=7 and x<=9 and y==4 then
				t=wall
			else
			 t=floor
			end
			column[y]=t
		end
		tiles[x]=column
	end
	return tiles
end