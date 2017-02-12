require('collision')
require('entities/entities')

players = {}
bullets = {}

function createPlayer()
	local num = table.getn(objects)+1
	local playerNum = table.getn(players)+1
	players[playerNum] = num
	
	objects[num] = {
		gravity = 3000,
		img = nil,
    imagePath = "images/characters/dude.png",
		id = num,
    objType = "Player",
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
    facing = "right",
    jumpForce = 1200
	}
	
	objects[num].img = love.graphics.newImage("images/characters/dude.png")
	objects[num].width = objects[num].img:getWidth()
	objects[num].height = objects[num].img:getHeight()
  imagePath = "images/characters/dude.png"
	
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
			jump(player, dt)	
		elseif player.jumped == true and (player.grounded or player.rightCol or player.leftCol) then
			player.jumped = false
		end

		if love.keyboard.isDown(player.left) then
      moveLeft(player, dt)
		end
		if love.keyboard.isDown(player.right) then
      moveRight(player, dt)
		end
		
		if not love.keyboard.isDown(player.right)
		and not love.keyboard.isDown(player.left) then
			slowDown(player, dt)
		end
    
    fall(player, dt)
    
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
    imagePath = "images/characters/bullet.png",
		id = num,
		x = getPlayer(1).x,
		y = getPlayer(1).y+36,
		width = 0,
		height = 0,
		xSpeed = 0,
		ySpeed = 0
	}
	
	bullets[num].img = love.graphics.newImage("images/characters/bullet.png")
	bullets[num].width = bullets[num].img:getWidth()
	bullets[num].height = bullets[num].img:getHeight()
  
  if getPlayer(1).facing == "right" then
    bullets[num].xSpeed = 1000 + getPlayer(1).xSpeed/7
    bullets[num].x = getPlayer(1).x + getPlayer(1).width
  else
    bullets[num].xSpeed = -1000 + getPlayer(1).xSpeed/7
    bullets[num].x = getPlayer(1).x - bullets[num].width
  end
end

function bulletUpdate(dt)
  count = 1
  while count <= table.getn(bullets) do
    bullet = bullets[count]
    bullet.x = bullet.x + bullet.xSpeed*dt
    i = 1
    while i <= table.getn(enemies) do
      if simpleCollision(bullet, getEnemy(i)) then
        table.remove(bullets, count)
        getEnemy(i).health = getEnemy(i).health - 1
      end
      i = i + 1
    end
    count = count + 1
  end
end