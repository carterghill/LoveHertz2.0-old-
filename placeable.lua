placeable = {}
placeableNum = 1

function newPlaceable(image, classx, namex)
	num = table.getn(placeable)+1
	placeable[num] = {
		img = nil,
    imagePath = image,
		class = classx,
    name = namex
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

function getPlaceables()
  
  -- Find placeable enemies
  
  local dir = "images/characters/enemies"
  --assuming that our path is full of lovely files (it should at least contain main.lua in this case)
  local files = love.filesystem.getDirectoryItems(dir)
  for k, file in ipairs(files) do
    newPlaceable(dir.."/"..file, "Enemy", file)
    --print(k .. ". " .. file) --outputs something like "1. main.lua"
  end
  
  -- Find placeable static objects
  
  dir = "images/static"
  files = love.filesystem.getDirectoryItems(dir)
  for k, file in ipairs(files) do
    newPlaceable(dir.."/"..file, "Static")
  end
  
  -- Find placeable tiles

  dir = "images/tiles"
  files = love.filesystem.getDirectoryItems(dir)
  for k, file in ipairs(files) do
    if file == "endLevel.png" then
      newPlaceable(dir.."/"..file, "End Level")
    else
      newPlaceable(dir.."/"..file, "Tile")
    end
  end
end