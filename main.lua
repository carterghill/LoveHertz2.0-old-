require('mouse') -- Handles all mouse actions
require('camera')
require('levels/objects')
require('levels/levels')
require('entities/enemy')
require('entities/player')
require('controls')
require('sequences')
editMode = true

thing = {
  {"hi", "1:2"},
  {"hello"}
  }
function love.load()

  joysticks = love.joystick.getJoysticks()
  getPlaceables()
  seqInit()
  dialInit()
  levelsInit()
	createPlayer()
  background = love.graphics.newImage("80's+City.jpg")
  newPlaceable("images/tiles/noCamera.png", "Camera Collider")
	newCamera()

end

words = ""
function love.draw()
  love.graphics.draw(background,0,0,0,0.5)
	drawObjects()
	if editMode then
		drawPlaceable()
		love.graphics.print("Edit mode Enabled", 10, 10)
    if levels[1] ~= nil then
      local x = levelNum-1
      love.graphics.print("Level: "..x.." / "..levels[1], 10, 30)
    end
    love.graphics.print("Press P to save level\nPress L to load saved level\nT toggles Edit Mode\n\"Y\" Sets the level start\n\"U\" Sets the camera start position", 10, 50)
  end
  drawDialog()
end


function love.update(dt)

  if love.keyboard.isDown("f") then
    dt = dt/5
  end
  
	if editMode then
		mouseCheck()
	end
	
	if table.getn(players) > 0 then
		lockOn(players[1], dt)
	end

	if not editMode then
    enemyUpdate(dt)
		playerUpdate(dt)
    bulletUpdate(dt)
    --if not inSequence then
      checkControls()
    --end
	end
  sequence(dt)
	camera(dt)
end

function love.keypressed(key)
  print(key)
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
    --print("hi")
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
  if not inSequence and key == controls[1].jump then
    jump(getPlayer(1), dt)
  end
  if key == "y" then
    setStart(getPlayer(1).x, getPlayer(1).y)
  end
  if key == "u" then
    setCameraStart(cameras[cameraNum].x, cameras[cameraNum].y)
  end
end

function love.keyreleased(key)
  if key == "space" and getPlayer(1).ySpeed < -400 then
    getPlayer(1).ySpeed = -400
  end
end

function love.mousepressed(x, y, button)
  if button == 1 and not editMode then
    print("hi")
    shoot(1)
  end
end


