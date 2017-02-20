require('levels/objects')
require('Tserial')
require('tablesave')

levels = {}
levelNum = 2
-- The "zeroeth level" is actually a placeholder for the 
-- amount of levels in the game

levels[1] = 1

function isempty(s)
  return s == nil
end

function levelsInit()
  levels[2] = {
    objs = objects,
    plyrs = players,
    enems = enemies,
    camCols = cameraColliders
  }
end

function setLevel(x)
  if x > 1 then
    levels[levelNum].objs = objects
    levels[levelNum].plyrs = players
    levels[levelNum].camCols = cameraColliders
    --objects = {}
    --players = {}
    --enemies = {}
    --cameraColliders = {}
    levelNum = x
    if x > levels[1] then
      levels[levelNum] = {objs = objects, plyrs = players, camCols = cameraColliders, enems = enemies }
      createPlayer()
      levels[1] = levels[1]+1
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
  --print(Tserial.pack(levels, {}, true))
  --print(love.filesystem.getIdentity( ))
  love.filesystem.write( "save.txt", Tserial.pack(levels, {}, false) )
end

function loadLevels()
  --levels = {}
  --levels = table.load("levels/levels.txt")
  if love.filesystem.read("save.txt") ~= "" then
    levels = Tserial.unpack(love.filesystem.read("save.txt"))
  end
  --enemyInit()
  
  if levels ~= nil then
    --objects = {}
    objects = levels[levelNum].objs
    --cameraColliders = {}
    cameraColliders = levels[levelNum].camCols
    --enemies = {}
    enemies = levels[levelNum].enems
    players = levels[levelNum].plyrs
    
    local i = 2
    while(i <= table.getn(levels)) do
      local j = 1
      while (j <= table.getn(levels[i].objs)) do
        levels[i].objs[j].img = love.graphics.newImage(levels[i].objs[j].imagePath)
        j=j+1
      end
      for j=1, table.getn(levels[i].enems) do
        levels[i].enems[j].img = love.graphics.newImage(levels[i].enems[j].imagePath)
      end
      for j=1, table.getn(levels[i].plyrs) do
        levels[i].plyrs[j].img = love.graphics.newImage(levels[i].plyrs[j].imagePath)
      end
      local j = 1
      while (j <= table.getn(levels[i].camCols)) do
        levels[i].camCols[j].img = love.graphics.newImage("images/tiles/noCamera.png")
        j=j+1
      end
      
      i = i+1
    end
  end
  enemyInit()
end