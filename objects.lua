objects = {}

function drawObjects()
	local count = 1
	while count <= table.getn(objects) do
		love.graphics.draw(objects[count].img,objects[count].x-cameras[cameraNum].x, objects[count].y-cameras[cameraNum].y)
		count = count + 1
	end
end

function createObject(mousex, mousey)
	num = table.getn(objects)+1
	objects[num] = {
		img = nil,
		x = mousex,
		y = mousey
	}
	
	objects[num].img = placeable[placeableNum].img
	
	if cameraNum > 0 then
		objects[num].x = x + cameras[cameraNum].x - objects[num].img:getWidth()/2
		objects[num].y = y + cameras[cameraNum].y - objects[num].img:getHeight()/2
	end
	
end