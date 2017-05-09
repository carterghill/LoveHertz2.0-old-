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
  print(button)
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

function love.keypressed(key)
  for i = 1, table.getn(players) do
    if key == controls[i].shoot then
      shoot(i)
    end
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
  if key == "escape" then
    love.event.quit()
  end
  if key == "t" then
    if editMode then
      editMode = false
    else
      editMode = true
    end
  end
  if key == "p" then
    saveLevels()
  end
  if key == "l" then
    loadLevels()
  end
  if key == "right" then
    setLevel(levelNum+1)
  end
  if key == "left" then
    setLevel(levelNum-1)
  end
  if not inSequence and key == controls[1].jump then
    for i = 1, table.getn(players) do
      if key == controls[i].jump then
        jump(getPlayer(i), dt)
        --jump(getPlayer(2), dt)
      end
    end
  end
  if key == "y" then
    setStart(getPlayer(1).x, getPlayer(1).y)
  end
  if key == "u" then
    setCameraStart(cameras[cameraNum].x, cameras[cameraNum].y)
  end
  if key == "i" then
    createPlayer()
    --getPlayer(2).
  end
  if key == "1" then
    placeable = "Tile"
  end
  if key == "2" then
    placeable = "Static"
  end
  if key == "3" then
    placeable = "Enemy"
  end
end

function love.keyreleased(key)
  for i = 1, table.getn(players) do
    if key == controls[i].jump and getPlayer(i).ySpeed < -400 then
      getPlayer(i).ySpeed = -400
    end
    if key == controls[i].up then
      getPlayer(i).up = false
    end
    if key == controls[i].down then
      getPlayer(i).down = false 
    end
    if key == controls[i].left then
      getPlayer(i).left = false
    end
    if key == controls[i].right then
      getPlayer(i).right = false
    end
  end
end

