cameras = {}
cameraNum = 0

function newCamera()
	local num = table.getn(cameras)+1
	cameras[num] = {
		x = 0,
		y = 0,
		xSpeed = 0,
		ySpeed = 0
	}
	if cameraNum == 0 then
		cameraNum = 1
	end
end

function camera(dt)
	
	cameras[cameraNum].x = cameras[cameraNum].x + cameras[cameraNum].xSpeed*dt
	cameras[cameraNum].y = cameras[cameraNum].y + cameras[cameraNum].ySpeed*dt
end

function lockOn(object, dt)
	
	--cameras[cameraNum].x = object.x + object.img:getWidth()/2 - 400
	--cameras[cameraNum].y = object.y + object.img:getHeight()/2 - 300
	
	moveTo(object, 0.2, dt)

end

-- moveTo: Moves the camera to the object in the alloted time
function moveTo(object, time, dt)
	cameras[cameraNum].xSpeed = ((object.x + object.img:getWidth()/2 - 400) - cameras[cameraNum].x)/time
	cameras[cameraNum].ySpeed = ((object.y + object.img:getHeight()/2 - 300) - cameras[cameraNum].y)/time

end