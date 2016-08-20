require('mouse') -- Handles all mouse actions
require('camera')
require('objects')


pic = nil

function love.load()
	newPlaceable(love.graphics.newImage("1225.png"), "Player")
	newPlaceable(love.graphics.newImage("smile.png"), "None")
	newPlaceable(love.graphics.newImage("neutral.png"), "None")
	newCamera()
end


function love.draw()
	drawObjects()
	x, y = getMouse()
	love.graphics.draw(placeable[placeableNum].img, x - placeable[placeableNum].img:getWidth()/2, y - placeable[placeableNum].img:getHeight()/2)
	--if table.getn(objects) > 0 then
		love.graphics.print(table.getn(placeable), 10, 10)
	--end
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



