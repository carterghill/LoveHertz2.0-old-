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
		cameras[cameraNum].x = cameras[cameraNum].x + 5
	end
end

function lockOn(object)
	
	cameras[cameraNum].x = object.x + object.img:getWidth()/2 - 400
	cameras[cameraNum].y = object.y + object.img:getHeight()/2 - 300
	
end