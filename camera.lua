cameras = {}
cameraNum = 0

function newCamera()
	local num = table.getn(cameras)+1
	cameras[num] = {
		x = 0,
		y = 0
	}
	if cameraNum == 0 then
		cameraNum = 1
	end
end

function camera(dt)
	if love.keyboard.isDown('d') then
		cameras[cameraNum].x = cameras[cameraNum].x + 1
		local count = 1
		while count <= table.getn(objects) do
			objects[count].relativeX = objects[count].relativeX - 1
			count = count + 1
		end
	end
end

function lockOn(object)
	
	cameras[cameraNum].x = object.globalX + object.img:getWidth()/2 - 400
	
	--dx = cameras[cameraNum].x - object.globalX
	--if dx ~= 0 then
		--cameras[cameraNum].x = object.globalX
		--local count = 1
		--while count <= table.getn(objects) do
			--object.relativeX = object.relativeX + dx --+400
			--count = count + 1
		--end
	--end
end