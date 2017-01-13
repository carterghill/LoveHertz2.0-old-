require('mouse') -- Handles all mouse actions
require('camera')
require('objects')
require('Tserial')
require('tablesave')
editMode = true

function isempty(s)
  return s == nil
end

function love.load()
  objects = table.load("lvl1.txt")
  print(table.getn(objects))
  i = 1
  while(i <= table.getn(objects)) do
    print(Tserial.pack(objects[i], "img = nil"))
    objects[i].img = love.graphics.newImage(objects[i].imagePath)
    if not isempty(objects[i].id) then
      local playerNum = table.getn(players)+1
      players[playerNum] = i
    end
    i = i+1
  end
	newPlaceable("1225.png", "Player")
	newPlaceable("smile.png", "None")
	newPlaceable("neutral.png", "None")
	newPlaceable("tile.jpg", "Tile")
	newPlaceable("tile.png", "Tile")
	newPlaceable("tile.jpg", "Tile")
	newPlaceable("tile.jpg", "Tile")
	newCamera()
end


function love.draw()
	drawObjects()
	if editMode then
		drawPlaceable()
		love.graphics.print("Edit mode Enabled", 10, 10)
		if table.getn(objects)>2 then
		  love.graphics.print(Tserial.pack(objects, "img = nil"), 10, 30)
		end
	end
end


function love.update(dt)
	
	if editMode then
		mouseCheck()
	end
	
	if table.getn(players) > 0 then
		lockOn(objects[players[1]], dt)
	end
	if love.keyboard.isDown('h') then
		lockOn(objects[5], dt)
	end	

	if not editMode then
		playerUpdate(dt)
		
	end
	camera(dt)
end

function love.keypressed(key)
  if key == "escape" then
    table.save(objects,"lvl1.txt")
    love.event.quit()
  end
  if key == "t" then
    if editMode then
      editMode = false
    else
      editMode = true
    end
  end
end



