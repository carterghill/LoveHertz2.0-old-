require('collision')

players = {}

-- Creates a player, adds it to the objects list, and saves it's objectNum to players
function createPlayer(mousex, mousey)
	local num = table.getn(objects)+1
	local playerNum = table.getn(players)+1
	players[playerNum] = num
	
	objects[num] = {
		img = nil,
		id = num,
		x = mousex,
		y = mousey,
		width = 0,
		height = 0,
		runSpeed = 750,
		xSpeed = 0,
		ySpeed = 0,
		accel = 500,
		up = "w",
		down = "s",
		left = 'a',
		right = 'd'
	}
	
	objects[num].img = placeable[placeableNum].img
	objects[num].width = objects[num].img:getWidth()
	objects[num].height = objects[num].img:getHeight()
	
	if cameraNum > 0 then
		objects[num].x = mousex + cameras[cameraNum].x - objects[num].width/2
		objects[num].y = mousey + cameras[cameraNum].y - objects[num].height/2
	end
	
end

-- Returns player num
function getPlayer(num)
	return objects[players[num]]
end

function playerUpdate(dt)
	local count = 1
	while count <= table.getn(players) do
		player = getPlayer(count)
		if love.keyboard.isDown(objects[players[count]].up) then
			player.ySpeed = player.ySpeed - player.accel*dt
			if player.ySpeed < -player.runSpeed then
				player.ySpeed = -player.runSpeed
			end
		end
		if love.keyboard.isDown(objects[players[count]].left) then
			player.xSpeed = player.xSpeed - player.accel*dt
			if player.xSpeed < -player.runSpeed then
				player.xSpeed = -player.runSpeed
			end
		end
		if love.keyboard.isDown(objects[players[count]].right) then
			player.xSpeed = player.xSpeed + player.accel*dt
			if player.xSpeed > player.runSpeed then
				player.xSpeed = player.runSpeed
			end
		end
		if love.keyboard.isDown(objects[players[count]].down) then
			player.ySpeed = player.ySpeed + player.accel*dt
			if player.ySpeed > player.runSpeed then
				player.ySpeed = player.runSpeed
			end
			
		end
		
		if not love.keyboard.isDown(objects[players[count]].down)
		and not love.keyboard.isDown(objects[players[count]].up) then
			if player.ySpeed > 0 + player.accel*dt then
				player.ySpeed = player.ySpeed - player.accel*dt
			elseif player.ySpeed < 0 - player.accel*dt then
				player.ySpeed = player.ySpeed + player.accel*dt
			else 
				player.ySpeed = 0
			end
		end
		
		if not love.keyboard.isDown(objects[players[count]].right)
		and not love.keyboard.isDown(objects[players[count]].left) then
			if player.xSpeed > 0 + player.accel*dt then
				player.xSpeed = player.xSpeed - player.accel*dt
			elseif player.xSpeed < 0 - player.accel*dt then
				player.xSpeed = player.xSpeed + player.accel*dt
			else 
				player.xSpeed = 0
			end
		end
		
		collision(player,dt)
		player.y = player.y + player.ySpeed*dt
		player.x = player.x + player.xSpeed*dt
		count = count + 1
	end
end