mouseDown = {false, false, false, false, false}

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
		message = "Clicked! :D"
		x, y = love.mouse.getPosition( )
		createObject(x,y)
	end
	if button == 2 then
		message2 = "Clicked! :D"
	end
end

function onRelease(button)
	-- If LEFT mouse button is released
	if button == 1 then
		--mouseDown[count] = false
		message = "Not Clicked :("
	end
	if button == 2 then
		message2 = "Not Clicked :("
	end
end
 
function love.wheelmoved(x, y)
    if y > 0 then
        cur = cur + 1
		if cur > table.getn(placeable) then
			cur = 1
		end
    elseif y < 0 then
        cur = cur - 1
		if cur < 1 then
			cur = table.getn(placeable)
		end
    end
end