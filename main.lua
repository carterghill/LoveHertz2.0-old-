require('mouse') -- Handles all mouse actions
require('camera')
require('draw')

objects = {}
placeable = {}
cur = 1

pic = nil

function love.load()
	placeable[1] = love.graphics.newImage("1225.png")
	placeable[2] = love.graphics.newImage("neutral.png")
	placeable[3] = love.graphics.newImage("smile.png")
	newCamera()
end


function love.draw()
	drawObjects()
	x, y = getMouse()
	love.graphics.draw(placeable[cur], x - placeable[cur]:getWidth()/2, y - placeable[cur]:getHeight()/2)
	if table.getn(objects) > 0 then
		love.graphics.print(objects[table.getn(objects)].globalX, 10, 10)
	end
end


function love.update(dt)
	mouseCheck()
	camera(dt)
	if table.getn(objects) > 0 then
		lockOn(objects[1])
		if love.keyboard.isDown('a') then
			objects[1].globalX = objects[1].globalX - 1
		end
	end
	if love.keyboard.isDown('h') then
		lockOn(objects[1])
	end	
	
	
end



function createObject(x, y)
	num = table.getn(objects)+1
	objects[num] = {
		relativeX = x,
		relativeY = y,
		img = nil,
		globalX = x,
		globalY = y
	}
	
	objects[num].img = placeable[cur]
	objects[num].relativeX = x - objects[num].img:getWidth()/2
	objects[num].relativeY = y - objects[num].img:getHeight()/2
	
	if cameraNum > 0 then
		objects[num].globalX = x + cameras[cameraNum].x - objects[num].img:getWidth()/2
		objects[num].globalY = y - cameras[cameraNum].y - objects[num].img:getHeight()/2
	end
	
end