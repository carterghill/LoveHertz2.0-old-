
function drawObjects()
	local count = 1
	while count <= table.getn(objects) do
		love.graphics.draw(objects[count].img,objects[count].globalX-cameras[cameraNum].x, objects[count].relativeY)
		count = count + 1
	end
end