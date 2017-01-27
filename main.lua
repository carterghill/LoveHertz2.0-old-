require('mouse') -- Handles all mouse actions
require('camera')
require('objects')
require('levels')
editMode = true

function love.load()
  levelsInit()
	createPlayer()
	newPlaceable("smile.png", "None")
	newPlaceable("neutral.png", "None")
	newPlaceable("tile.jpg", "Tile")
	newPlaceable("tile.png", "Tile")
	newPlaceable("tile.jpg", "Tile")
	newPlaceable("tile.jpg", "Tile")
	newCamera()
  print(tostring(cameras[cameraNum].x))
end

words = ""
function love.draw()
	drawObjects()
  --m = definePoints(getPlayer(1))
  love.graphics.print(words, 10, 50)
	if editMode then
		drawPlaceable()
		love.graphics.print("Edit mode Enabled", 10, 10)
    love.graphics.print("Level: "..levelNum.." / "..levels[0], 10, 30)
    
	end
  
  if table.getn(objects) > 3 then
    p = objects[players[1]]
    o = objects[2]
    --love.graphics.print(tostring(pointInObject(getPlayer(1).x, getPlayer(1).y, objects[2])), 10, 70)
    --love.graphics.print(tostring(checkCollision(objects[players[1]], o)), 10, 90)
    --checkCollision(getPlayer(1), objects[count])
  end
end


function love.update(dt)
  --dt = dt/10
	
	if editMode then
		mouseCheck()
	end
	
	if table.getn(players) > 0 then
		lockOn(objects[players[1]], dt)
	end
	if love.keyboard.isDown('h') then
		lockOn(objects[5], dt)
	end	

	if not editMode then
		playerUpdate(dt)
		
	end
	camera(dt)
end

function love.keypressed(key)
  if key == "escape" then
    love.event.quit()
  end
  if key == "t" then
    if editMode then
      editMode = false
    else
      editMode = true
    end
  end
  if key == "p" then
    saveLevels()
  end
  if key == "l" then
    loadLevels()
  end
  if key == "right" then
    setLevel(levelNum+1)
  end
  if key == "left" then
    setLevel(levelNum-1)
  end
end

function love.keyreleased(key)
  if key == "space" and objects[players[1]].ySpeed < -400 then
    objects[players[1]].ySpeed = -400
  end
end



