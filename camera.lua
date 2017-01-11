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
	if editMode then
	   if love.keyboard.isDown('d') then
	     cameras[cameraNum].x = cameras[cameraNum].x + 300*dt
	   end
	   if love.keyboard.isDown('a') then
       cameras[cameraNum].x = cameras[cameraNum].x + -300*dt
     end
     if love.keyboard.isDown('s') then
       cameras[cameraNum].y = cameras[cameraNum].y + 300*dt
     end
     if love.keyboard.isDown('w') then
       cameras[cameraNum].y = cameras[cameraNum].y - 300*dt
     end
	else
	  cameras[cameraNum].x = cameras[cameraNum].x + cameras[cameraNum].xSpeed*dt
	  cameras[cameraNum].y = cameras[cameraNum].y + cameras[cameraNum].ySpeed*dt
	end
end

function lockOn(object, dt)
	
	--cameras[cameraNum].x = object.x + object.img:getWidth()/2 - 400
	--cameras[cameraNum].y = object.y + object.img:getHeight()/2 - 300
	
	moveTo(object, 0.2, dt)

end

-- moveTo: Moves the camera to the object in the alloted time
function moveTo(object, time, dt)
	cameras[cameraNum].xSpeed = ((object.x + object.xSpeed/3 + object.img:getWidth()/2 - 400) - cameras[cameraNum].x)/time
	cameras[cameraNum].ySpeed = ((object.y + object.ySpeed/10 + object.img:getHeight()/2 - 300) - cameras[cameraNum].y)/time

end