collisions = {}

-- Collision detection function;
-- Returns true if two boxes overlap, false if they don't;
-- x1,y1 are the top-left coords of the first box, while w1,h1 are its width and height;
-- x2,y2,w2 & h2 are the same, but for the second box.
function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

function collision( player, dt )
	
  player.grounded = false
  player.rightCol = false
  player.leftCol = false
  
  local count = 1
	while count <= table.getn(objects) do
		if CheckCollision(player.x-1,player.y-1, player.width+2, player.height+2, 
        objects[count].x, objects[count].y, objects[count].width, objects[count].height) 
        and count ~= player.id then
          
      if math.abs(objects[count].x - player.x) < math.abs(objects[count].y - player.y) then
        if player.ySpeed > 0 then
          player.grounded = true
          player.ySpeed = 0
          player.y = objects[count].y - player.height
        else
          
        end
      else
        if player.xSpeed > 0 then
          player.rightCol = true
          player.xSpeed = 0
          player.x = objects[count].x - player.width
        else
          
        end
      end
    
    end
		count = count + 1
	end
end