require('mouse') -- Handles all mouse actions
require('camera')
require('objects')
editMode = true

function love.load()
	newPlaceable(love.graphics.newImage("1225.png"), "Player")
	newPlaceable(love.graphics.newImage("smile.png"), "None")
	newPlaceable(love.graphics.newImage("neutral.png"), "None")
	newPlaceable(love.graphics.newImage("tile.jpg"), "Tile")
	newPlaceable(love.graphics.newImage("tile.jpg"), "Tile")
	newPlaceable(love.graphics.newImage("tile.jpg"), "Tile")
	newPlaceable(love.graphics.newImage("tile.jpg"), "Tile")
	newCamera()
end


function love.draw()
	drawObjects()
	if editMode then
		drawPlaceable()
		love.graphics.print("Edit mode Enabled", 10, 10)
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
		camera(dt)
	end
	
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
end



