collisions = {}

function checkCollision(p, o)
  return p.x < o.x+o.width and
         o.x < p.x+p.width and
         p.y < o.y+o.height and
         o.y < p.y+p.height
end

function collision( player, dt )
	
  player.grounded = false
  player.rightCol = false
  player.leftCol = false
  player.upCol = false
  
  local count = 1
	while count <= table.getn(objects) do
    
    if checkCollision(player, objects[count]) then
		
      x_overlap = math.max(0, math.min(player.x,player.x+player.width) 
        - math.max(objects[count].x,objects[count].x+objects[count].width));
      y_overlap = math.max(0, math.min(player.y+player.height,player.y) 
        - math.max(objects[count].y+objects[count].height,objects[count].y));
      
      horiz = {player.x, player.x+player.width, objects[count].x, objects[count].x+objects[count].width}
      table.sort(horiz)
      vert = {player.y, player.y+player.height, objects[count].y, objects[count].y+objects[count].height}
      table.sort(vert);
      
      y_overlap = vert[2] - vert[1]
      x_overlap = horiz[2] - horiz[1]
      --print("x: "..x_overlap)
      --words = tostring(y_overlap)
     
      if y_overlap<128 and y_overlap > 64 and y ~= 0 then
        y_overlap = y_overlap - 64
        --print(y_overlap)
        --print(x_overlap)
        if y_overlap > x_overlap then 
          player.ySpeed = 0
          player.grounded = true
          player.y = objects[count].y - player.height
        else
          player.xSpeed = 0
          if player.x > objects[count].x then
            player.leftCol = true
            player.x = objects[count].x + objects[count].width
          else
            player.rightCol = true
            player.x = objects[count].x - player.width 
          end
        end
      elseif y_overlap<64 and y_overlap > 0 and y ~= 0 then
        y_overlap = y_overlap - 32
        x_overlap = x_overlap - 32
        print(x_overlap)
        print(y_overlap)
        if y_overlap > x_overlap then 
          player.ySpeed = 0
          player.grounded = true
          player.y = objects[count].y + objects[count].height
        else
          player.xSpeed = 0
          if player.x > objects[count].x then
            player.leftCol = true
            player.x = objects[count].x + objects[count].width
          else
            player.rightCol = true
            player.x = objects[count].x - player.width 
          end
        end
      end
		end
    count = count + 1
	end
end