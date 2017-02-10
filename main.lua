require('mouse') -- Handles all mouse actions
require('camera')
require('levels/objects')
require('levels/levels')
require('entities/enemy')
require('entities/player')
editMode = true

function love.load()
  levelsInit()
	createPlayer()
	newPlaceable("images/static/smile.png", "None")
	newPlaceable("images/static/neutral.png", "None")
	newPlaceable("images/tiles/tile.jpg", "Tile")
	newPlaceable("images/tiles/tile.png", "Tile")
	newPlaceable("images/tiles/tile.jpg", "Tile")
	newPlaceable("images/characters/enemy.png", "Enemy")
  newPlaceable("images/tiles/noCamera.png", "Camera Collider")
	newCamera()
  loadLevels()
  enemyInit()
end

words = ""
function love.draw()
	drawObjects()
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
    enemyUpdate(dt)
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
  if button == 1 and not editMode then
    print("hi")
    shoot()
  end
end


