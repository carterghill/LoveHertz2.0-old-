players = {}

-- Creates a player, adds it to the objects list, and saves it's objectNum to players
function createPlayer(mousex, mousey)
	local num = table.getn(objects)+1
	local playerNum = table.getn(players)+1
	players[playerNum] = num
	
	objects[num] = {
		img = nil,
		x = mousex,
		y = mousey,
		width = 0,
		height = 0,
		runSpeed = 100,
		up = "w",
		down = "s",
		left = 'a',
		right = 'd'
	}
	
	objects[num].img = placeable[cur]
	
	if cameraNum > 0 then
		objects[num].x = mousex + cameras[cameraNum].x - objects[num].img:getWidth()/2
		objects[num].y = mousey + cameras[cameraNum].y - objects[num].img:getHeight()/2
	end
	
end

function playerUpdate(dt)
	local count = 1
	while count <= table.getn(players) do
		if love.keyboard.isDown(objects[players[count]].up) then
			objects[players[count]].y = objects[players[count]].y - objects[players[count]].runSpeed*dt
		end
		if love.keyboard.isDown(objects[players[count]].left) then
			objects[players[count]].x = objects[players[count]].x - objects[players[count]].runSpeed*dt
		end
		if love.keyboard.isDown(objects[players[count]].right) then
			objects[players[count]].x = objects[players[count]].x + objects[players[count]].runSpeed*dt
		end
		if love.keyboard.isDown(objects[players[count]].down) then
			objects[players[count]].y = objects[players[count]].y + objects[players[count]].runSpeed*dt
		end
		count = count + 1
	end
end