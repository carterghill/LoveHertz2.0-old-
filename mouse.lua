require('player')
require('placeable')
mouseDown = {false, false, false, false, false}
classText = "ha"

function mouseCheck()
	local count = 1
	while count <= 5 do
		if love.mouse.isDown(count) and not mouseDown[count] then
			mouseDown[count] = true
			onClick(count)
		end
		if not love.mouse.isDown(count) and mouseDown[count] then
			mouseDown[count] = false
			onRelease(count)
		end
		count = count + 1
	end
	
end

function getMouse()
	return love.mouse.getPosition( )
end

function onClick(button)
	-- If LEFT mouse button is clicked
	if button == 1 then
		x, y = love.mouse.getPosition( )
		classText = placeable[placeableNum].class
		if classText == "None" then
			createObject(x,y)
		elseif classText == "Player" then
			createPlayer(x,y)
		elseif classText == "Tile" then
			classText = tostring(offset)
			offsetx = (x + cameras[cameraNum].x) % 64
			offsety = (y + cameras[cameraNum].y) % 64
			classText = "x = "..tostring(x)..", offset = "..tostring(offset)
			if offsetx < 64 then
				placex = x - offsetx 

				classText = "x = "..tostring(x)..", place = "..tostring(placex)
				if offsety < 64 then
					createObject(placex,y-offsety)
				else
					createObject(placex,y+offsety)
				end
			else
				placex = x + offsetx
				classText = "x = "..tostring(x)..", place = "..tostring(placex)
				if offsety < 64 then
					createObject(placex,y-offsety)
				else
					createObject(placex,y+offsety)
				end
			end
		end
	end
	if button == 2 then

	end
end

function onRelease(button)
	-- If LEFT mouse button is released
	if button == 1 then

	end
	if button == 2 then

	end
end
 
function love.wheelmoved(x, y)
    if y > 0 then
        placeableNum = placeableNum + 1
		if placeableNum > table.getn(placeable) then
			placeableNum = 1
		end
    elseif y < 0 then
        placeableNum = placeableNum - 1
		if placeableNum < 1 then
			placeableNum = table.getn(placeable)
		end
    end
end