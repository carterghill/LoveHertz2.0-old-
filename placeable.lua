placeable = {}
placeableNum = 1

function newPlaceable(image, classx)
	num = table.getn(placeable)+1
	placeable[num] = {
		img = nil,
		class = classx
	}
	placeable[num].img = image
end