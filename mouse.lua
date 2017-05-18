require('placeable')
require('camera')
mouseDown = {false, false, false, false, false}
classText = "ha"

function mouseCheck()
	local count = 1
	while count <= 5 do
		if love.mouse.isDown(count) and not mouseDown[count] then
			mouseDown[count] = true
			onClick(count)
		end
		if not love.mouse.isDown(count) and mouseDown[count] then
			mouseDown[count] = false
			onRelease(count)
		end
		count = count + 1
	end
	
end

function getMouse()
	return love.mouse.getPosition( )
end

function onClick(button)
	-- If LEFT mouse button is clicked
	if button == 1 then
		x, y = love.mouse.getPosition( )
    if onUI == true then
      onClickUI(x, y)
    else
      classText = placeable
      if placeableEnemies ~= nil then
        name = placeableEnemies[placeableEnemyNum].name
      end
      --print(name)
      if classText == "None" or classText == "Static" or classText == nil then
        createObject(x,y)
      elseif classText == "Player" then
        createPlayer(x,y)
      elseif classText == "Tile" then
        createTile(x,y)
      elseif classText == "Camera Collider" then
        createCameraCollider(x,y)
      elseif classText == "Enemy" then
        createEnemy(x,y, name)
      elseif classText == "End Level" then
        createEndLevelTile(x, y)
      end
    end
	end
	if button == 2 then
    deleteObject(x, y)
	end
end

function onRelease(button)
	-- If LEFT mouse button is released
	if button == 1 then

	end
	if button == 2 then

	end
end
 
function love.wheelmoved(x, y)
  if y > 0 then
    
    if placeable == "Tile" or placeable == "End Level" then
      placeableTileNum = placeableTileNum + 1
      if placeableTileNum > table.getn(placeableTiles) then
        placeableTileNum = 1
      end
      elseif y < 0 then
          placeableTileNum = placeableTileNum - 1
      if placeableTileNum < 1 then
        placeableTileNum = table.getn(placeableTiles)
      end
    elseif placeable == "Static" or placeable == "None" or placeable == nil then
      placeableStaticNum = placeableStaticNum + 1
      if placeableStaticNum > table.getn(placeableStatic) then
        placeableStaticNum = 1
      end
      elseif y < 0 then
          placeableStaticNum = placeableStaticNum - 1
      if placeableStaticNum < 1 then
        placeableStaticNum = table.getn(placeableStatic)
      end
    elseif placeable == "Enemy" then
      placeableEnemyNum = placeableEnemyNum + 1
      if placeableEnemyNum > table.getn(placeableEnemies) then
        placeableEnemyNum = 1
      end
      elseif y < 0 then
          placeableEnemyNum = placeableEnemyNum - 1
      if placeableEnemyNum < 1 then
        placeableEnemyNum = table.getn(placeableEnemies)
      end
    end
    
  elseif y < 0 then
    if placeable == "Tile" or placeable == "End Level" then
      placeableTileNum = placeableTileNum - 1
      if placeableTileNum < 1 then
        placeableTileNum = table.getn(placeableTiles)
      end
    elseif placeable == "Static" or placeable == "None" or placeable == nil then
      placeableStaticNum = placeableStaticNum - 1
      if placeableStaticNum < 1 then
        placeableStaticNum = table.getn(placeableStatic)
      end
    elseif placeable == "Enemy" then
      placeableEnemyNum = placeableEnemyNum - 1
      if placeableEnemyNum < 1 then
        placeableEnemyNum = table.getn(placeableEnemies)
      end
    end
  end
end

function deleteObject(x, y)
  local count = 1
	while count <= table.getn(objects) do
    
    if x + cameras[cameraNum].x > objects[count].x and x + cameras[cameraNum].x <
    objects[count].x + objects[count].width then
      
      if y + cameras[cameraNum].y > objects[count].y and y + cameras[cameraNum].y <
      objects[count].y + objects[count].height then
        
        if objects[count].objType == "Enemy" then
          deleteEntity(objects[count])
        else
          table.remove(objects, count)
          for i=count, table.getn(objects) do
            objects[i].id = objects[i].id - 1
          end
        end
      end
    end 
    count = count + 1
  end
  
  count = 1
  while count <= table.getn(cameraColliders) do
    
    if x + cameras[cameraNum].x > cameraColliders[count].x and x + cameras[cameraNum].x <
    cameraColliders[count].x + cameraColliders[count].width then
      
      if y + cameras[cameraNum].y > cameraColliders[count].y and y + cameras[cameraNum].y <
      cameraColliders[count].y + cameraColliders[count].height then
        table.remove(cameraColliders, count)
      end
    end 
    count = count + 1
  end
end

function createTile(x, y)

  offsetx = (x + cameras[cameraNum].x) % 64
  offsety = (y + cameras[cameraNum].y) % 64
  
  if offsetx < 64 then
    placex = x - offsetx 
    if offsety < 64 then
      placey = y-offsety
    else
      placey = y+offsety
    end
  else
    placex = x + offsetx
    if offsety < 64 then
      placey = y-offsety
    else
      placey = y+offsety
    end
  end
  
  
  num = table.getn(objects)+1
	objects[num] = {
    id = num,
    objType = "Tile",
		img = nil,
    imagePath = placeableTiles[placeableTileNum].imagePath,
		width = 0,
		height = 0,
		x = placex,
		y = placey,
		xSpeed = 0,
		ySpeed = 0,
		scale = 1
	}
	
	objects[num].img = placeableTiles[placeableTileNum].img
	objects[num].width = objects[num].img:getWidth()
	objects[num].height = objects[num].img:getHeight()
	
	if cameraNum > 0 then
		objects[num].x = objects[num].x + cameras[cameraNum].x - objects[num].img:getWidth()/2
		objects[num].y = objects[num].y + cameras[cameraNum].y - objects[num].img:getHeight()/2
		
	end
  
  
  --if objects[table.getn(objects)].width ~= 64 then
    objects[table.getn(objects)].scale = 64/objects[table.getn(objects)].width
    
    objects[table.getn(objects)].x = objects[table.getn(objects)].x + (objects[table.getn(objects)].width - 64)/2 + 32
    objects[table.getn(objects)].y = objects[table.getn(objects)].y + (objects[table.getn(objects)].width - 64)/2 + 32
    objects[table.getn(objects)].width = objects[table.getn(objects)].width*(64/objects[table.getn(objects)].width)
    objects[table.getn(objects)].height = objects[table.getn(objects)].width
  --else
    --objects[table.getn(objects)].x = objects[table.getn(objects)].x + 64
    --objects[table.getn(objects)].y = objects[table.getn(objects)].y + 64
  --end
end

function createCameraCollider(mousex, mousey)
  num = table.getn(cameraColliders)+1
	cameraColliders[num] = {
    id = num,
		img = nil,
    imagePath = placeable[placeableNum].imagePath,
		width = 0,
		height = 0,
		x = mousex,
		y = mousey,
		xSpeed = 0,
		ySpeed = 0,
		scale = 1
	}
	
  x = x - ((x + cameras[cameraNum].x) % 64)
  y = y - ((y + cameras[cameraNum].y) % 64)
  
	cameraColliders[num].img = placeable[placeableNum].img
	cameraColliders[num].width = cameraColliders[num].img:getWidth()
	cameraColliders[num].height = cameraColliders[num].img:getHeight()
	
	if cameraNum > 0 then
		cameraColliders[num].x = x + cameras[cameraNum].x - cameraColliders[num].img:getWidth()/2 + 32
		cameraColliders[num].y = y + cameras[cameraNum].y - cameraColliders[num].img:getHeight()/2 + 32
		
	end
end