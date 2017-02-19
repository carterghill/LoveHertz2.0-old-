require('levels/objects')
require('Tserial')
require('tablesave')

levels = {}
levelNum = 1
-- The "zeroeth level" is actually a placeholder for the 
-- amount of levels in the game

levels[0] = 1

function isempty(s)
  return s == nil
end

function levelsInit()
  levels[1] = {
    objs = objects,
    plyrs = players,
    enems = enemies,
    camCols = cameraColliders
  }
end

function setLevel(x)
  if x > 0 then
    levels[levelNum].objs = objects
    levels[levelNum].plyrs = players
    levels[levelNum].camCols = cameraColliders
    objects = {}
    players = {}
    enemies = {}
    cameraColliders = {}
    levelNum = x
    if x > levels[0] then
      levels[levelNum] = {objs = objects, plyrs = {}, camCols = cameraColliders, enems = enemies }
      createPlayer()
      levels[0] = levels[0]+1
    else
      objects = levels[levelNum].objs
      players = levels[levelNum].plyrs
      cameraColliders = levels[levelNum].camCols
      enemies = levels[levelNum].enems
    end
  end
end

function saveLevels()
  table.save(levels,"levels/levels.txt")
end

function loadLevels()
  levels = {}
  levels = table.load("levels/levels.txt")
  
  objects = {}
  objects = levels[levelNum].objs
  cameraColliders = {}
  cameraColliders = levels[levelNum].camCols
  enemies = {}
  enemies = levels[levelNum].enems
  
  local i = 1
  while(i <= table.getn(levels)) do
    local j = 1
    while (j <= table.getn(levels[i].objs)) do
      --print("image: "..tostring(levels[i].objs[j].imagePath))
      levels[i].objs[j].img = love.graphics.newImage(levels[i].objs[j].imagePath)
      if not isempty(levels[i].objs[j].id) then
        local playerNum = table.getn(players)+1
      end
      j=j+1
    end
    for j=1, table.getn(levels[i].enems) do
      levels[i].enems[j].img = love.graphics.newImage(levels[i].enems[j].imagePath)
    end
    local j = 1
    while (j <= table.getn(levels[i].camCols)) do
      levels[i].camCols[j].img = love.graphics.newImage("images/tiles/noCamera.png")
      j=j+1
    end
    
    i = i+1
  end
  
end