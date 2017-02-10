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