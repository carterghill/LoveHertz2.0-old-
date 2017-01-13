tiles = {}
tileNum = 1

function createTile(mousex, mousey)
  if cameraNum ~= 0 then
    x = mousex + cameras[cameraNum].x - placeable[placeableNum].img:getWidth()/2
    y = mousey + cameras[cameraNum].y - placeable[placeableNum].img:getHeight()/2
  end
	tiles[x/64][y/64] = {
		img = nil,
    imagePath = placeable[placeableNum].imagePath,
		width = 0,
		height = 0,
		x = mousex,
		y = mousey,
		xSpeed = 0,
		ySpeed = 0,
		scale = 1
	}
	
	tiles[x/64][y/64].img = placeable[placeableNum].img
	tiles[x/64][y/64].width = tiles[x/64][y/64].img:getWidth()
	tiles[x/64][y/64].height = tiles[x/64][y/64].img:getHeight()

end

function tileCollision(player, dt)
  
end