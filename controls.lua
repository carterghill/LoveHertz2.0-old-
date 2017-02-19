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

function checkControls()
  for i=1, table.getn(controls) do
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

function love.keypressed()
  if key == controls[1].jump then
    jump(getPlayer(1), dt)
  end
end