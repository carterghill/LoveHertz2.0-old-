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
    --loadLevels()
  seqInit()
  dialInit()
  levelsInit()
	createPlayer()
	newPlaceable("images/static/smile.png", "None", "lol")
	newPlaceable("images/static/neutral.png", "None", "lol")
	newPlaceable("images/tiles/tile.jpg", "Tile", "lol")
	newPlaceable("images/tiles/tile.png", "Tile", "lol")
	newPlaceable("images/tiles/tile.jpg", "Tile", "lol")
	newPlaceable("images/characters/paul.png", "Enemy", "paul")
  newPlaceable("images/characters/frank.png", "Enemy", "frank")
  newPlaceable("images/tiles/noCamera.png", "Camera Collider")
	newCamera()

  enemyInit()
  thing[table.getn(thing)+1] = {"3:1","3:2"}
end

words = ""
function love.draw()
	drawObjects()
  love.graphics.print(thing[3][2], 10, 50)
	if editMode then
		drawPlaceable()
		love.graphics.print("Edit mode Enabled", 10, 10)
    love.graphics.print("Level: "..levelNum.." / "..levels[0], 10, 30)
	else
    --love.graphics.print(tostring(table.getn(bullets)))
  end
  drawDialog()
end


function love.update(dt)
	if getPlayer(1).x < 200 then
    displayDialog("x < 200", dt)
  end 
  if love.keyboard.isDown("f") then
    dt = dt/5
  end
  
	if editMode then
		mouseCheck()
	end
	
	if table.getn(players) > 0 then
		lockOn(objects[players[1]], dt)
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
    inSequence = not inSequence
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


