placeable = "Tile"
placeableTileNum = 1
placeableTiles = {}
placeableStaticNum = 1
placeableStatic = {}
placeableEnemyNum = 1
placeableEnemies = {}

function newPlaceable(image, classx, namex)
  
  if classx == "Tile" or classx == "End Level" then
    num = table.getn(placeableTiles)+1
    print(table.getn(placeableTiles))
    placeableTiles[num] = {
      img = nil,
      imagePath = image,
      class = classx,
      name = namex
    }
    placeableTiles[num].img = love.graphics.newImage(image)
  elseif classx == "Static" or classx == "None" or classx == nil then
    num = table.getn(placeableStatic)+1
    placeableStatic[num] = {
      img = nil,
      imagePath = image,
      class = classx,
      name = namex
    }
    placeableStatic[num].img = love.graphics.newImage(image)
  elseif classx == "Enemy" then
    num = table.getn(placeableEnemies)+1
    placeableEnemies[num] = {
      img = nil,
      imagePath = image,
      class = classx,
      name = namex
    } 
    placeableEnemies[num].img = love.graphics.newImage(image)
  end

end

function drawPlaceable()
	x, y = getMouse()
  love.graphics.setColor( 255, 255, 255, 150 )
	if placeable == "Tile" then 
    
    x = x - ((x + cameras[cameraNum].x) % 64) + 32
    y = y - ((y + cameras[cameraNum].y) % 64) + 32
    
    if placeableTiles[placeableTileNum].img:getWidth() == 128 then
	   love.graphics.draw(placeableTiles[placeableTileNum].img, x - placeableTiles[placeableTileNum].img:getWidth()/4, y 
        - placeableTiles[placeableTileNum].img:getHeight()/4 , 0, 0.5)
    else 
      love.graphics.draw(placeableTiles[placeableTileNum].img, x - placeableTiles[placeableTileNum].img:getWidth()/2, y 
		    - placeableTiles[placeableTileNum].img:getHeight()/2)
    end

	elseif placeable == "Enemy" then
    love.graphics.draw(placeableEnemies[placeableEnemyNum].img, x - placeableEnemies[placeableEnemyNum].img:getWidth()/2, y 
		    - placeableEnemies[placeableEnemyNum].img:getHeight()/2)
      
  elseif placeable == "Static" then
    love.graphics.draw(placeableStatic[placeableStaticNum].img, x - placeableStatic[placeableStaticNum].img:getWidth()/2, y 
		    - placeableStatic[placeableStaticNum].img:getHeight()/2)
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