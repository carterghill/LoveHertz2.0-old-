
function drawObjects()
	local count = 1
	while count <= table.getn(objects) do
		love.graphics.draw(objects[count].img,objects[count].x-cameras[cameraNum].x, objects[count].y-cameras[cameraNum].y)
		count = count + 1
	end
end