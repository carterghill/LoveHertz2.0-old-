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
          
      if player.x < objects[count].x and player.y < objects[count].y then
       
        if math.abs((player.x+player.width)- objects[count].x) < math.abs(player.y+player.height - objects[count].y) then
          player.xSpeed = 0
          player.x = objects[count].x - player.width
        else
          player.grounded = true
          player.ySpeed = 0
          player.y = objects[count].y - player.height
        end
        
      elseif player.x > objects[count].x and player.y < objects[count].y  then
        
        if (objects[count].x+objects[count].width)- player.x > objects[count].y -player.y+player.height then
          player.xSpeed = 0
          player.x = objects[count].x + objects[count].width
        else
          player.grounded = true
          player.ySpeed = 0
          player.y = objects[count].y - player.height
        end
        
      end
    end
		count = count + 1
	end
end