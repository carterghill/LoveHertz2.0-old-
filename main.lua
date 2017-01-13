require('mouse') -- Handles all mouse actions
require('camera')
require('objects')
require('Tserial')
require('tablesave')
require('levels')
editMode = true

function isempty(s)
  return s == nil
end

function love.load()
  levelsInit()
	newPlaceable("1225.png", "Player")
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
		if table.getn(objects)>2 then
		  love.graphics.print(Tserial.pack(objects, "img = nil"), 10, 30)
		end
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
end



