tiles = {}
tileNum = 1

function newTile(image)
	num = table.getn(placeable)+1
	placeable[num] = {
		img = nil,
		class = "Tile"
	}
	placeable[num].img = image
end

function drawPlaceable()
	x, y = getMouse()
	love.graphics.draw(placeable[placeableNum].img, x - placeable[placeableNum].img:getWidth()/2, y 
		- placeable[placeableNum].img:getHeight()/2)
end