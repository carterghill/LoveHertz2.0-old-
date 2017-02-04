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
  love.graphics.setColor( 255, 255, 255, 150 )
	if placeable[placeableNum].class == "Tile" or placeable[placeableNum].class == "Camera Collider" then 
    
    x = x - ((x + cameras[cameraNum].x) % 64) + 32
    y = y - ((y + cameras[cameraNum].y) % 64) + 32
    
    if placeable[placeableNum].img:getWidth() == 128 then
	   love.graphics.draw(placeable[placeableNum].img, x - placeable[placeableNum].img:getWidth()/4, y 
        - placeable[placeableNum].img:getHeight()/4 , 0, 0.5)
    else 
      love.graphics.draw(placeable[placeableNum].img, x - placeable[placeableNum].img:getWidth()/2, y 
		    - placeable[placeableNum].img:getHeight()/2)
    end
	else
	   love.graphics.draw(placeable[placeableNum].img, x - placeable[placeableNum].img:getWidth()/2, y 
		    - placeable[placeableNum].img:getHeight()/2)
	end
  love.graphics.setColor( 255, 255, 255, 255 )
end