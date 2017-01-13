placeable = {}
placeableNum = 1

function newPlaceable(image, classx)
	num = table.getn(placeable)+1
	placeable[num] = {
		img = nil,
    imagePath = image,
		class = classx
	}
	placeable[num].img = love.graphics.newImage(image)
end

function drawPlaceable()
	x, y = getMouse()
	if placeable[placeableNum].class == "Tile" and placeable[placeableNum].img:getWidth() == 128 then 
	   love.graphics.draw(placeable[placeableNum].img, x - placeable[placeableNum].img:getWidth()/4, y 
        - placeable[placeableNum].img:getHeight()/4, 0, 0.5)
	else
	   love.graphics.draw(placeable[placeableNum].img, x - placeable[placeableNum].img:getWidth()/2, y 
		    - placeable[placeableNum].img:getHeight()/2)
	end
end