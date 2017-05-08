endLevelTiles = {}

function createEndLevelTile(mousex, mousey)
	num = table.getn(endLevelTiles)+1
	endLevelTiles[num] = {
    id = num,
    objType = "End Level",
		img = nil,
    imagePath = "images/tiles/endLevel.png",
		width = 0,
		height = 0,
		x = mousex,
		y = mousey,
		xSpeed = 0,
		ySpeed = 0,
		scale = 1
	}
  
  x = x - ((x + cameras[cameraNum].x) % 64)
  y = y - ((y + cameras[cameraNum].y) % 64)
	
	endLevelTiles[num].img = placeable[placeableNum].img
	endLevelTiles[num].width = endLevelTiles[num].img:getWidth()
	endLevelTiles[num].height = endLevelTiles[num].img:getHeight()

	if cameraNum > 0 then
		endLevelTiles[num].x = endLevelTiles[num].x + cameras[cameraNum].x - endLevelTiles[num].img:getWidth()/2
		endLevelTiles[num].y = endLevelTiles[num].y + cameras[cameraNum].y - endLevelTiles[num].img:getHeight()/2
		
	end
	
end

function endLevel()
  for i=1, table.getn(endLevelTiles) do
    for j=1, table.getn(players) do
      if simpleCollision(getPlayer(j), endLevelTiles[i]) then
        nextLevel()
      end
    end
  end
end