require('mouse') -- Handles all mouse actions
require('camera')
require('objects')

function love.load()
	newPlaceable(love.graphics.newImage("1225.png"), "Player")
	newPlaceable(love.graphics.newImage("smile.png"), "None")
	newPlaceable(love.graphics.newImage("neutral.png"), "None")
	newCamera()
end


function love.draw()
	drawObjects()
	drawPlaceable()
	love.graphics.print(table.getn(placeable), 10, 10)
end


function love.update(dt)
	mouseCheck()
	camera(dt)
	if table.getn(players) > 0 then
		lockOn(objects[players[1]])
	end
	if love.keyboard.isDown('h') then
		lockOn(objects[1])
	end	
	playerUpdate(dt)
	
end



