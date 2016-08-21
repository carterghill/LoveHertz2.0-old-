collisions = {}

function collision( player, dt )
	local count = 1
	while count <= table.getn(objects) do
		if player.ySpeed > 0 and count ~= player.id and player.y < objects[count].y then
			if player.y + player.height + player.ySpeed*dt > objects[count].y then
				if player.x < objects[count].x + objects[count].width + 3
				and player.x + player.width > objects[count].x then
					player.ySpeed = 0
					player.y = objects[count].y - player.height
				end
			end			
		elseif player.ySpeed < 0 and count ~= player.id and player.y > objects[count].y then
			if player.y - player.ySpeed*dt - 3  < objects[count].y + objects[count].height then
				if player.x < objects[count].x + objects[count].width +4
				and player.x + player.width > objects[count].x then
					player.ySpeed = 0
					player.y = objects[count].y + objects[count].height
				end
			end			
		end
		
		if player.xSpeed > 0 and count ~= player.id and player.x < objects[count].x then
			if player.x + player.width + player.xSpeed*dt > objects[count].x then
				if player.y < objects[count].y + objects[count].height
				and player.y + player.height > objects[count].y then
					player.xSpeed = 0
					player.x = objects[count].x - player.width
				end
			end			
		elseif player.xSpeed < 0 and count ~= player.id and player.x > objects[count].x then
			if player.x - player.xSpeed*dt - 3  < objects[count].x + objects[count].height +3 then
				if player.y < objects[count].y + objects[count].width
				and player.y + player.width + 3> objects[count].y then
					player.xSpeed = 0
					player.x = objects[count].x + objects[count].height
				end
			end			
		end
		
		count = count + 1
	end
end