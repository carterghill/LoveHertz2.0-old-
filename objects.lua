objects = {}

function drawObjects()
	local count = 1
	while count <= table.getn(objects) do
		love.graphics.draw(objects[count].img,objects[count].x-cameras[cameraNum].x,
         objects[count].y-cameras[cameraNum].y, 0, objects[count].scale)
		count = count + 1
	end
end

function createObject(mousex, mousey)
	num = table.getn(objects)+1
	objects[num] = {
		img = nil,
    imagePath = placeable[placeableNum].imagePath,
		width = 0,
		height = 0,
		x = mousex,
		y = mousey,
		xSpeed = 0,
		ySpeed = 0,
		scale = 1
	}
	
	objects[num].img = placeable[placeableNum].img
	objects[num].width = objects[num].img:getWidth()
	objects[num].height = objects[num].img:getHeight()
	
	if cameraNum > 0 then
		objects[num].x = objects[num].x + cameras[cameraNum].x - objects[num].img:getWidth()/2
		objects[num].y = objects[num].y + cameras[cameraNum].y - objects[num].img:getHeight()/2
		
	end
	
end