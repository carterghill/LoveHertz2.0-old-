onUI = false
-- UI is it's own table, containing each UI "object"
-- Every iteam of the UI will have it's own img, x, and y values
UI = {
  
  --onUI = false,
  
    Tile = {
      img = love.graphics.newImage("UI/tileIcon.png"),
      x = love.graphics.getWidth()/4.5,
      y = love.graphics.getHeight()/25,
      width = 0,
      height = 0
    },
    
    Static = {
      img = love.graphics.newImage("UI/staticIcon.png"),
      x = love.graphics.getWidth()/4.5 + 80,
      y = love.graphics.getHeight()/25,
      width = 0,
      height = 0
    },
    
    Enemy = {
      img = love.graphics.newImage("UI/enemyIcon.png"),
      x = love.graphics.getWidth()/4.5 + 160,
      y = love.graphics.getHeight()/25,
      width = 0,
      height = 0
    }
}
text = ""

function loadUI()
  for k, v in pairs(UI) do
    UI[k].width = UI[k].img:getWidth()/2
    UI[k].height = UI[k].img:getHeight()/2
  end
end

function drawUI()
  
  -- ///////////////
  -- EDIT MODE TEXT
  -- ///////////////
  
  if editMode then
    
    -- Placeable categories
    love.graphics.draw(UI.Tile.img, UI.Tile.x, UI.Tile.y, 0, 0.5)
    love.graphics.draw(UI.Static.img, UI.Static.x, UI.Static.y, 0, 0.5)
    love.graphics.draw(UI.Enemy.img, UI.Enemy.x, UI.Enemy.y, 0, 0.5)
    
    love.graphics.setLineWidth( 4 )
    love.graphics.setColor(0, 200, 0)
    love.graphics.rectangle("line", UI[placeable].x, UI[placeable].y, UI[placeable].width, UI[placeable].height)
    love.graphics.setColor(255, 255, 255)

    
    
		drawPlaceable()
		love.graphics.print("Edit mode Enabled", 10, 10)
    if levels[1] ~= nil then
      local x = levelNum-1
      love.graphics.print("Level: "..x.." / "..levels[1], 10, 30)
    end
    text = "Press P to save level\n"
    text = text.."Press L to load saved level\n"
    text = text.."T toggles Edit Mode\n\"Y\" Sets the level start\n\"U\" Sets the camera start position\nEnd Level Tiles: "
    text = text..table.getn(endLevelTiles).."\nCamera Colliders: "..table.getn(cameraColliders).."\n"..placeable
    if onUI == true then
      text = text.."On UI"
    end
    love.graphics.print(text, 10, 50)
    
  end
  
end


function onClickUI(x, y)
  
    for k, v in pairs(UI) do
      if pointInObject(x, y, UI[k]) then
        placeable = k
      end
    end
  
end

function updateUI()
  onUI = false
  x, y = love.mouse.getPosition( )
  for k, v in pairs(UI) do
    if pointInObject(x, y, UI[k]) then
      onUI = true
    end
  end
end