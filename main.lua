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
  print(exp(2,7))
end

function exp(x, y)
  if y == 0 then
    return 1
  elseif y == 1 then
    return x
  elseif y == 2 then
    return x*x
  end
  
  if (y % 2) == 0 then
    return exp(exp(x, y/2), 2)
  else 
    return x*exp(x, y-1)
  end
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
end


function love.update(dt)
	
  if love.keyboard.isDown("f") then
    dt = dt/5
  end
  
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
    bulletUpdate(dt)
		
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
  if key == "e" then
    print("hi")
    shoot()
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

function love.mousepressed(x, y, button)
  if button == "1" then
    print("hi")
    shoot()
  end
end


