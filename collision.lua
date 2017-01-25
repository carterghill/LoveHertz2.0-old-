collisions = {}

function checkCollision(p, o)
  return p.x < o.x+o.width and
         o.x < p.x+p.width and
         p.y < o.y+o.height and
         o.y < p.y+p.height
end

function collision( player, dt )
	
  player.grounded = 0
  player.rightCol = 0
  player.leftCol = 0
  player.upCol = 0
  points = definePoints(player)
  bottom = 0
  left = 0
  right = 0
  top = 0
  
  local count = 1
	while count <= table.getn(objects) do
    
    if checkCollision(player, objects[count]) and count ~= player.id then
      
      i = 1
      while i <= 5 do
        if pointInObject(points[i].x, points[i].y, objects[count]) then
          top = top + 1
        end
        i = i + 1
      end
      
      i = 5
      while i <= 9 do
        if pointInObject(points[i].x, points[i].y, objects[count]) then
          right = right + 1
        end
        i = i + 1
      end
      
      i = 9
      while i <= 13 do
        if pointInObject(points[i].x, points[i].y, objects[count]) then
          bottom = bottom + 1
        end
        i = i + 1
      end  
      
      i = 13
      while i <= 16 do
        if pointInObject(points[i].x, points[i].y, objects[count]) then
          left = left + 1
        end
        i = i + 1
      end 
      if pointInObject(points[1].x, points[1].y, objects[count]) then
        left = left + 1
      end
      print("left: "..tostring(left))
      print("right: "..tostring(right))
      print("up: "..tostring(up))
      print("down: "..tostring(down))
      
      if left < 2 and right < 2 and top < 2 and bottom < 2 then
        checkOverlap(player, objects[count])
      elseif(right > 1) then
        player.rightCol = true
        player.xSpeed = 0
        player.x = objects[count].x - player.width
      elseif left > 1 then
        player.leftCol = true
        player.xSpeed = 0
      elseif bottom >= top then
        player.grounded = true
        player.ySpeed = 0
        player.y = objects[count].y - player.height
      end
      
		end
    count = count + 1
	end
end

function definePoints(p)
  points = {
    {x = p.x+1, y = p.y},
    {x = p.x+p.width*.25, y = p.y},
    {x = p.x+p.width*.5, y = p.y},
    {x = p.x+p.width*.75, y = p.y},
    {x = p.x+p.width-1, y = p.y},
    {x = p.x+p.width, y = p.y+p.height*.25},
    {x = p.x+p.width, y = p.y+p.height*.5},
    {x = p.x+p.width, y = p.y+p.height*.75},
    {x = p.x+p.width-1, y = p.y+p.height},
    {x = p.x+p.width*.75, y = p.y+p.height},
    {x = p.x+p.width*.5, y = p.y+p.height},
    {x = p.x+p.width*.25, y = p.y+p.height},
    {x = p.x, y = p.y+p.height},
    {x = p.x, y = p.y+p.height*.75},
    {x = p.x, y = p.y+p.height*.5},
    {x = p.x, y = p.y+p.height*.25}
  }
  return points
end

function checkOverlap(player, object)
      x_overlap = math.max(0, math.min(player.x,player.x+player.width) 
        - math.max(object.x,object.x+object.width));
      y_overlap = math.max(0, math.min(player.y+player.height,player.y) 
        - math.max(object.y+object.height,object.y));
      
      horiz = {player.x, player.x+player.width, object.x, object.x+object.width}
      table.sort(horiz)
      vert = {player.y, player.y+player.height, object.y, object.y+object.height}
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
          player.y = object.y - player.height
        else
          player.xSpeed = 0
          if player.x > object.x then
            player.leftCol = true
            player.x = object.x + object.width
          else
            player.rightCol = true
            player.x = object.x - player.width 
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
          if player.x > object.x then
            player.leftCol = true
            player.x = object.x + object.width
          else
            player.rightCol = true
            player.x = object.x - player.width 
          end
        end
      end
end

function pointInObject(x, y, o)
  return x >= o.x and
    x <= o.x+o.width and
    y >= o.y and
    y <= o.y+o.height
end