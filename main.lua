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
end


function love.draw()
	drawObjects()
	if editMode then
		drawPlaceable()
		love.graphics.print("Edit mode Enabled", 10, 10)
    love.graphics.print("Level: "..levelNum.." / "..levels[0], 10, 30)
	end
end


function love.update(dt)
	
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



