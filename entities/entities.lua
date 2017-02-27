function moveLeft(ent, dt)
  ent.facing = "left"
  ent.xSpeed = ent.xSpeed - ent.accel*dt
  if ent.xSpeed < -ent.runSpeed then
    ent.xSpeed = -ent.runSpeed
  end
end

function moveRight(ent, dt)
  ent.facing = "right"
  ent.xSpeed = ent.xSpeed + ent.accel*dt
  if ent.xSpeed > ent.runSpeed then
    ent.xSpeed = ent.runSpeed
  end
end

function slowDown(ent, dt)
  if ent.xSpeed > 0 + ent.accel*dt then
    ent.xSpeed = ent.xSpeed - ent.accel*dt
  elseif ent.xSpeed < 0 - ent.accel*dt then
    ent.xSpeed = ent.xSpeed + ent.accel*dt
  else 
    ent.xSpeed = 0
  end
end

function fall(ent, dt)
  if not ent.grounded then
    ent.ySpeed = ent.ySpeed + ent.gravity*dt
    if ent.ySpeed > ent.fallSpeed then
      ent.ySpeed = ent.fallSpeed
    end
  end
end

function grounded(ent)
  for i = 1, table.getn(objects) do
    if ent.y + ent.height + 2 > objects[i].y and i ~= ent.id then
      if ent.x+ent.width > objects[i].x and ent.x < objects[i].x + objects[i].width then
        if ent.y + ent.height < objects[i].y + objects[i].height/2 then
          return true
        end
      end
    end
  end
  return false
end

function jump(ent)
  --print("jumped = "..tostring(ent.jumped).."\ngrounded = "..tostring(ent.grounded))
  if grounded(ent) then
    ent.ySpeed = -1200
    ent.y = ent.y
    ent.jumped = true
    --ent.jumped = true
  elseif ent.rightCol then
    ent.ySpeed = -1200
    ent.xSpeed = -player.runSpeed*1.5
    --ent.jumped = true
  elseif ent.leftCol then
    ent.ySpeed = -1200
    ent.xSpeed = ent.runSpeed*1.5
    --ent.jumped = true
  end	
end

function getx(ent)
  return ent.x - cameras[cameraNum].x
end

function gety(ent)
  return ent.y - cameras[cameraNum].y
end

function deleteEntity(ent)
  local id = ent.id
  local idHolder = 0
  if ent.objType == "Enemy" then
    for i=1, table.getn(enemies) do
      if getEnemy(i).id == id then
        idHolder = i
      end
    end
  end
  table.remove(objects, ent.id)
  table.remove(enemies, idHolder)
  for i=id, table.getn(objects) do
    objects[i].id = objects[i].id - 1
  end
end