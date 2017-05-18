objects = {}

function drawObjects(dt)
	local count = 1
	while count <= table.getn(objects) do
    if objects[count] ~= nil then
      love.graphics.draw(objects[count].img,objects[count].x-cameras[cameraNum].x,
         objects[count].y-cameras[cameraNum].y, 0, objects[count].scale)
    end
		count = count + 1
	end
  count = 1
	while count <= table.getn(bullets) do
		love.graphics.draw(bullets[count].img,bullets[count].x-cameras[cameraNum].x,
         bullets[count].y-cameras[cameraNum].y, 0, bullets[count].scale)
		count = count + 1
	end
  count = 1
	while count <= table.getn(cameraColliders) do
		love.graphics.draw(cameraColliders[count].img,cameraColliders[count].x-cameras[cameraNum].x,
         cameraColliders[count].y-cameras[cameraNum].y, 0, cameraColliders[count].scale)
		count = count + 1
	end
  for i = 1, table.getn(enemies) do
    if getEnemy(i) ~= nil then
      love.graphics.print(getEnemy(i).health, getx(getEnemy(i)), gety(getEnemy(i))-20)
      love.graphics.draw(getEnemy(i).img, getx(getEnemy(i)), gety(getEnemy(i)), 0, getEnemy(i).scale)
    else
      --print(tostring(i))
    end
  end
  for i = 1, table.getn(players) do
    if getPlayer(i) ~= nil then
      love.graphics.print(tostring(getPlayer(i).health), getx(getPlayer(i)), gety(getPlayer(i))-20)
      love.graphics.setColor(255,255,255,getPlayer(i).alpha)
      if getPlayer(i).walkAnim:getFrame() ~= nil then
        love.graphics.draw(getPlayer(i).walkAnim:getFrame(), getx(getPlayer(i)), gety(getPlayer(i)), 0, getPlayer(i).scale)
      else
        love.graphics.draw(getPlayer(i).img, getx(getPlayer(i)), gety(getPlayer(i)), 0, getPlayer(i).scale)
      end
      love.graphics.setColor(255,255,255,255)
    end
  end
  for i = 1, table.getn(endLevelTiles) do
    if endLevelTiles[i] ~= nil then
      love.graphics.setColor(255,255,255,endLevelTiles[i].alpha)
      love.graphics.draw(endLevelTiles[i].img, getx(endLevelTiles[i]), gety(endLevelTiles[i]), 0, endLevelTiles[i].scale)
      love.graphics.setColor(255,255,255,255)
    end
  end
end

function createObject(mousex, mousey)
	num = table.getn(objects)+1
	objects[num] = {
    id = num,
    objType = "Static",
		img = nil,
    imagePath = placeableStatic[placeableStaticNum].imagePath,
		width = 0,
		height = 0,
		x = mousex,
		y = mousey,
		xSpeed = 0,
		ySpeed = 0,
		scale = 1
	}
	
	objects[num].img = placeableStatic[placeableStaticNum].img
	objects[num].width = objects[num].img:getWidth()
	objects[num].height = objects[num].img:getHeight()
	
	if cameraNum > 0 then
		objects[num].x = objects[num].x + cameras[cameraNum].x - objects[num].img:getWidth()/2
		objects[num].y = objects[num].y + cameras[cameraNum].y - objects[num].img:getHeight()/2
		
	end
	
end