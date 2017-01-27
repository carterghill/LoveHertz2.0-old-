function collision( player, dt )
  
  player.grounded = false
  player.rightCol = false
  player.leftCol = false
  player.upCol = false
  
  local count = 1
	while count <= table.getn(objects) do
    
    if player.xSpeed > 0 and player.x + player.width + player.xSpeed*dt > objects[count].x and count ~= player.id then
      if player.y+player.height > objects[count].y and player.y < objects[count].y + objects[count].height then
        if player.x < objects[count].x + objects[count].width/2 then
          player.x = objects[count].x - player.width
          player.xSpeed = 0
          player.rightCol = true
          --print("wtf")
        end
      end
		end
    
    if player.xSpeed < 0 and player.x + player.xSpeed*dt < objects[count].x + objects[count].width and count ~= player.id then
      if player.y+player.height > objects[count].y and player.y < objects[count].y + objects[count].height then
        if player.x >= objects[count].x + objects[count].width/2 then
          player.x = objects[count].x + objects[count].width
          player.xSpeed = 0
          player.leftCol = true
          --print("wtf")
        end
      end
		end
    
    if player.ySpeed > 0 and player.y + player.height + player.ySpeed*dt > objects[count].y and count ~= player.id then
      if player.x+player.width > objects[count].x and player.x < objects[count].x + objects[count].width then
        if player.y + player.height < objects[count].y + objects[count].height/2 then
          player.y = objects[count].y - player.height
          player.ySpeed = 0
          player.grounded = true
          --print("wtf")
        end
      end
		end
    
    if player.ySpeed < 0 and player.y + player.ySpeed*dt < objects[count].y + objects[count].height and count ~= player.id then
      if player.x+player.width > objects[count].x and player.x < objects[count].x + objects[count].width then
        if player.y > objects[count].y + objects[count].height then
          player.y = objects[count].y + objects[count].height
          player.ySpeed = 0
          player.upCol = true
          print("Player.y: "..tostring(player.y).." object bottom: "..tostring(objects[count].y))
        end
      end
		end
    
    count = count + 1
	end
end