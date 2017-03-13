-- Controls will be a 2D array
-- The first index is the player number
controls = {}
controlsEnabled = true

controls[1] = {
  
  left = "a",
  right = "d",
  up = "w",
  down = "s",
  jump = "space",
  shoot = "e"
  
}

controls[2] = {
  
  left = "b",
  right = "m",
  up = "h",
  down = "n",
  jump = "k",
  shoot = "j"
  
}
function checkControls()
  for i=1, table.getn(controls) do
    if getPlayer(i) ~= nil then
      if love.keyboard.isDown(controls[i].up) and not inSequence  then
        getPlayer(i).up = true
      else
        getPlayer(i).up = false
      end
      if love.keyboard.isDown(controls[i].left) and not inSequence  then
        getPlayer(i).left = true
      else
        getPlayer(i).left = false
      end
      if love.keyboard.isDown(controls[i].right) and not inSequence  then
        getPlayer(i).right = true
      else
        getPlayer(i).right = false
      end
      if love.keyboard.isDown(controls[i].down) and not inSequence then
        getPlayer(i).down = true
      else
        getPlayer(i).down = false
      end
    end
  end
  for i = 1, table.getn(joysticks) do
    if getPlayer(i) ~= nil then
      if joysticks[i]:getHat(1) == 'r' and not inSequence then
         getPlayer(i).right = true
      else
         getPlayer(i).right = false
      end
      if joysticks[i]:getHat(1) == 'l' and not inSequence then
         getPlayer(i).left = true
      else
         getPlayer(i).left = false
      end
      if joysticks[i]:getHat(1) == 'u' and not inSequence then
         getPlayer(i).up = true
      else
         getPlayer(i).up = false
      end
      if joysticks[i]:getHat(1) == 'd' and not inSequence then
         getPlayer(i).down = true
      else
         getPlayer(i).down = false
      end
    end
  end
end

function playerKeys()
  print("umm")
  for i = 1, table.getn(players) do
    if key == controls[i].jump then
      jump(getPlayer(i))
    end
    if key == controls[i].up then
      getPlayer(i).up = true
    end
    if key == controls[i].down then
      getPlayer(i).down = true
    end
    if key == controls[i].left then
      getPlayer(i).left = true
    end
    if key == controls[i].right then
      getPlayer(i).right = true
    end
  end
  if key == "k" then
    jump(getPlayer(2), dt)
  end
end
function love.joystickpressed(joystick,button)
  local i = joystick:getID()
  local joysticks = love.joystick.getJoysticks()
  print(joysticks[1]:getHat(1))
  if getPlayer(i) ~= nil then
    if button == 2 then
      jump(getPlayer(i))
    end
    if button == 1 then
      shoot(i)
    end
    if button == "dpup" then
      getPlayer(i).up = true
    end
    if button == "dpdown" then
      getPlayer(i).down = true
    end
    if button == "dpleft" then
      getPlayer(i).left = true
    end
    if button == "dpright" then
      getPlayer(i).right = true
    end
  end
end

function love.gamepadpressed( joystick, button )
  local i = joystick:getID()
  if getPlayer(i) ~= nil then
    if button == "a" then
      jump(getPlayer(i))
    end
    if button == "x" then
      shoot(i)
    end
    if button == "dpup" then
      getPlayer(i).up = true
    end
    if button == "dpdown" then
      getPlayer(i).down = true
    end
    if button == "dpleft" then
      getPlayer(i).left = true
    end
    if button == "dpright" then
      getPlayer(i).right = true
    end
  end
  print("gamepad pressed")
end

function love.gamepadreleased( joystick, button )
  local i = joystick:getID()
  if getPlayer(i) ~= nil then
    if button == "a" and getPlayer(1).ySpeed < -400 then
      getPlayer(i).ySpeed = -400
    end
    if button == "x" then
      --shoot(i)
    end
    if button == "dpup" then
      getPlayer(i).up = false
    end
    if button == "dpdown" then
      getPlayer(i).down = false
    end
    if button == "dpleft" then
      getPlayer(i).left = false
    end
    if button == "dpright" then
      getPlayer(i).right = false
    end
  end
  print(button)
end
