require('collision')

enemies = {}

function enemyInit()
  for i=1, table.getn(enemies) do
    enemy = getEnemy(i)
    if enemy.name == "paul" then
      print("paul here")
      function enemy:action(dt)
        if getPlayer(1).x > self.x then
          moveRight(self, dt)
        else
          moveLeft(self, dt)
        end
      end
    end
    if enemy.name == "frank" then
      function enemy:action(dt)
        
        self.actionTimer = self.actionTimer + dt
        if self.actionTimer > 4 then
          self.jumped = false
          --self.grounded = true
          jump(self, dt)
          self.actionTimer = 0
        end
        
      end
    end
  end
end

function createEnemy(mousex, mousey)
	local num = table.getn(objects)+1
	local enemyNum = table.getn(enemies)+1
	enemies[enemyNum] = num
	
	objects[num] = {
		gravity = 3000,
    name = "frank",
		img = nil,
    imagePath = "images/characters/enemy.png",
		id = num,
		x = mousex,
		y = mousey,
		width = 0,
		height = 0,
		runSpeed = 300,
		fallSpeed = 1000,
		xSpeed = 0,
		ySpeed = 0,
		accel = 2500,
    rightCol = false,
    leftCol = false,
		grounded = false,
		jumped = true,
    facing = "right",
    up = "i",
    down = "k",
    left = "j",
    right = "l",
    actionTimer = 0
	}
	
  enemyInit()
  
	objects[num].img = love.graphics.newImage("images/characters/enemy.png")
	objects[num].width = objects[num].img:getWidth()
	objects[num].height = objects[num].img:getHeight()
  imagePath = "images/characters/enemy.png"
	
	if cameraNum > 0 then
		objects[num].x = objects[num].x + cameras[cameraNum].x - objects[num].width/2
		objects[num].y = objects[num].y + cameras[cameraNum].y - objects[num].height/2
	end
	
end

-- Returns enemy object
function getEnemy(num)
	return objects[enemies[num]]
end

function enemyUpdate(dt)
	local count = 1
	while count <= table.getn(enemies) do
		enemy = getEnemy(count)
    
    fall(enemy, dt)
    
    collision(enemy,dt)
    enemy:action(dt)

		--collision(enemy,dt)
		enemy.y = enemy.y + enemy.ySpeed*dt
		enemy.x = enemy.x + enemy.xSpeed*dt
		count = count + 1
	end
end

