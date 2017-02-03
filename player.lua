require('collision')

players = {}
bullets = {}

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
		up = "q",
		down = "s",
		left = 'a',
		right = 'd',
    rightCol = false,
    leftCol = false,
		grounded = false,
		jumped = true,
    facing = "right"
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
		if love.keyboard.isDown("space") then
			if player.grounded and player.jumped == false then
				player.ySpeed = -1200
        player.y = player.y
				player.jumped = true
			elseif player.rightCol and player.jumped == false then
				player.ySpeed = -1200
        player.xSpeed = -player.runSpeed*1.5
				player.jumped = true
			elseif player.leftCol and player.jumped == false then
				player.ySpeed = -1200
        player.xSpeed = player.runSpeed*1.5
				player.jumped = true
			end		
		elseif player.jumped == true and (player.grounded or player.rightCol or player.leftCol) then
			player.jumped = false
		end

		if love.keyboard.isDown(player.left) then
      player.facing = "left"
			player.xSpeed = player.xSpeed - player.accel*dt
			if player.xSpeed < -player.runSpeed then
				player.xSpeed = -player.runSpeed
			end
		end
		if love.keyboard.isDown(player.right) then
      player.facing = "right"
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
    
    if (player.rightCol or player.leftCol) and player.ySpeed > 0 then
      player.ySpeed = player.ySpeed*0.85
    end

		collision(player,dt)
		player.y = player.y + player.ySpeed*dt
		player.x = player.x + player.xSpeed*dt
		count = count + 1
	end
end

function shoot()
  local num = table.getn(bullets)+1

	bullets[num] = {
		img = nil,
    imagePath = "bullet.png",
		id = num,
		x = getPlayer(1).x,
		y = getPlayer(1).y+24,
		width = 0,
		height = 0,
		xSpeed = 0,
		ySpeed = 0
	}
	
	bullets[num].img = love.graphics.newImage("bullet.png")
	bullets[num].width = bullets[num].img:getWidth()
	bullets[num].height = bullets[num].img:getHeight()
  
  if getPlayer(1).facing == "right" then
    bullets[num].xSpeed = 1000
    bullets[num].x = getPlayer(1).x + getPlayer(1).width
  else
    bullets[num].xSpeed = -1000
    bullets[num].x = getPlayer(1).x - bullets[num].width
  end
end

function bulletUpdate(dt)
  count = 1
  while count <= table.getn(bullets) do
    bullet = bullets[count]
    bullet.x = bullet.x + bullet.xSpeed*dt
    i = 1
    while i <= table.getn(objects) do
      if simpleCollision(bullet, objects[i]) then
        table.remove(bullets, count)
      end
      i = i + 1
    end
    count = count + 1
  end
end

function bulletCollision(bullet)
  count = 1
  --while count <= table.getn(objects) do
    --if count ~= bullet.id and simpleCollision(bullet, objects[count]) then
      --return true
    --end
    count = count + 1
  --end
  return false
end