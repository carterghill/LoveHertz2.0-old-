require('collision')

enemies = {}

function createEnemy(mousex, mousey, namex)
	local num = table.getn(enemies)+1

	
	enemies[num] = {
		gravity = 3000,
    name = namex,
		img = nil,
    imagePath = placeable[placeableNum].imagePath,
		id = num,
    objType = "Enemy",
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
    actionTimer = 0,
    health = 10
	}
	
  enemyInit()
  
	enemies[num].img = placeable[placeableNum].img
	enemies[num].width = enemies[num].img:getWidth()
	enemies[num].height = enemies[num].img:getHeight()
	
	if cameraNum > 0 then
		enemies[num].x = enemies[num].x + cameras[cameraNum].x - enemies[num].width/2
		enemies[num].y = enemies[num].y + cameras[cameraNum].y - enemies[num].height/2
	end
	
end

-- Returns enemy object
function getEnemy(num)
	return enemies[num]
end

function enemyUpdate(dt)
	local count = 1
	while count <= table.getn(enemies) do

		enemy = getEnemy(count)
    if enemy ~= nil then
    
      fall(enemy, dt)
      
      collision(enemy,dt)
      enemy:action(dt)

      if enemy.health <= 0 then
        --deleteEntity(enemy)
        table.remove(enemies, count)

      end
      
      enemy.y = enemy.y + enemy.ySpeed*dt
      enemy.x = enemy.x + enemy.xSpeed*dt
    end
		count = count + 1
	end
end


-- ////////////////////
-- ENEMY AI DEFINITIONS
-- ////////////////////


function enemyInit()
  
  for i=1, table.getn(enemies) do
    enemy = getEnemy(i)
    
    if enemy.name == "paul" then
      
      --enemy.health = 10
      enemy.accel = 500
      
      function enemy:action(dt)
       if getPlayer(1).x + getPlayer(1).width/2 > self.x + self.width/2 then
          moveRight(self, dt)
        else
          moveLeft(self, dt)
        end
     end
      
    elseif enemy.name == "frank" then
      
      --enemy.health = 10
      
      function enemy:action(dt)
        self.actionTimer = self.actionTimer + dt
        if self.actionTimer > 3 then
          self.jumped = false
          jump(self, dt)
          if getPlayer(1).x + getPlayer(1).width/2 > self.x + self.width/2 then
            self.xSpeed = 200
          else
            self.xSpeed = -200
          end
          self.actionTimer = 0
        end
        if grounded(self) and xSpeed ~= 0 and self.actionTimer > 0 then
          self.xSpeed = 0
        end
      end
    
    else
      
    end
    
  end
end
