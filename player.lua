require('collision')

players = {}

-- Creates a player, adds it to the objects list, and saves it's objectNum to players
function createPlayer(mousex, mousey)
	local num = table.getn(objects)+1
	local playerNum = table.getn(players)+1
	players[playerNum] = num
	
	objects[num] = {
		gravity = 3000,
		img = nil,
    imagePath = placeable[placeableNum].imagePath,
		id = num,
		x = mousex,
		y = mousey,
		width = 0,
		height = 0,
		runSpeed = 500,
		fallSpeed = 1000,
		xSpeed = 0,
		ySpeed = 0,
		accel = 2200,
		up = "w",
		down = "s",
		left = 'a',
		right = 'd',
    rightCol = false,
    leftCol = false,
		grounded = false,
		jumped = true
	}
	
	objects[num].img = placeable[placeableNum].img
	objects[num].width = objects[num].img:getWidth()
	objects[num].height = objects[num].img:getHeight()
  imagePath = placeable[placeableNum].imagePath
	
	if cameraNum > 0 then
		objects[num].x = mousex + cameras[cameraNum].x - objects[num].width/2
		objects[num].y = mousey + cameras[cameraNum].y - objects[num].height/2
	end
	
end

function createPlayer()
	local num = table.getn(objects)+1
	local playerNum = table.getn(players)+1
	players[playerNum] = num
	
	objects[num] = {
		gravity = 3000,
		img = nil,
    imagePath = "dude.png",
		id = num,
		x = 0,
		y = 0,
		width = 0,
		height = 0,
		runSpeed = 500,
		fallSpeed = 1000,
		xSpeed = 0,
		ySpeed = 0,
		accel = 3000,
		up = "w",
		down = "s",
		left = 'a',
		right = 'd',
    rightCol = false,
    leftCol = false,
		grounded = false,
		jumped = true
	}
	
	objects[num].img = love.graphics.newImage("dude.png")
	objects[num].width = objects[num].img:getWidth()
	objects[num].height = objects[num].img:getHeight()
  imagePath = "dude.png"
	
	if cameraNum > 0 then
		objects[num].x = cameras[cameraNum].x - objects[num].width/2
		objects[num].y = cameras[cameraNum].y - objects[num].height/2
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
			if player.grounded and player.jumped == false then
				player.ySpeed = -1200
        player.y = player.y-6
				player.jumped = true
			elseif player.rightCol and player.jumped == false then
				player.ySpeed = -1200
        player.xSpeed = -player.runSpeed*1.5
				player.jumped = true
			elseif player.leftCol and player.jumped == false then
				player.ySpeed = -1200
        player.xSpeed = player.runSpeed*1.5
        --player.x = player.x + 16
				player.jumped = true
			end		
		elseif player.jumped == true and (player.grounded or player.rightCol or player.leftCol) then
			player.jumped = false
		end

		if love.keyboard.isDown(player.left) then
			player.xSpeed = player.xSpeed - player.accel*dt
			if player.xSpeed < -player.runSpeed then
				player.xSpeed = -player.runSpeed
			end
		end
		if love.keyboard.isDown(player.right) then
			player.xSpeed = player.xSpeed + player.accel*dt
			if player.xSpeed > player.runSpeed then
				player.xSpeed = player.runSpeed
			end
		end
		if love.keyboard.isDown(player.down) then
			player.ySpeed = player.ySpeed + player.accel*dt
			if player.ySpeed > player.runSpeed then
				player.ySpeed = player.runSpeed
			end
			
		end
		
		if not love.keyboard.isDown(player.right)
		and not love.keyboard.isDown(player.left) then
			if player.xSpeed > 0 + player.accel*dt then
				player.xSpeed = player.xSpeed - player.accel*dt
			elseif player.xSpeed < 0 - player.accel*dt then
				player.xSpeed = player.xSpeed + player.accel*dt
			else 
				player.xSpeed = 0
			end
		end
		
		player.ySpeed = player.ySpeed + player.gravity*dt
		if player.ySpeed > player.fallSpeed then
		  player.ySpeed = player.fallSpeed
		end

		collision(player,dt)
		player.y = player.y + player.ySpeed*dt
		player.x = player.x + player.xSpeed*dt
		count = count + 1
	end
end

