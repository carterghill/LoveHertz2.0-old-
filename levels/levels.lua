require('levels/objects')
require('Tserial')
require('tablesave')

levels = {}
levelNum = 2

-- The first level is actually a placeholder for the 
-- amount of levels in the game
levels[1] = 1

function isempty(s)
  return s == nil
end

function levelsInit()
  levels[2] = {
    startx = 0,
    starty = 0,
    camx = 0,
    camy = 0,
    objs = objects,
    plyrs = players,
    enems = enemies,
    camCols = cameraColliders,
    endLvlTiles = endLevelTiles
  }
end

function setStart(x,y)
  if love.filesystem.read("save.txt") ~= "" then
    levels = Tserial.unpack(love.filesystem.read("save.txt"))
  end
  levels[levelNum].startx = x
  levels[levelNum].starty = y
  love.filesystem.write( "save.txt", Tserial.pack(levels, {}, false) )
end

function setCameraStart(x,y)
  if love.filesystem.read("save.txt") ~= "" then
    levels = Tserial.unpack(love.filesystem.read("save.txt"))
  end
  levels[levelNum].camx = x
  levels[levelNum].camy = y
  love.filesystem.write( "save.txt", Tserial.pack(levels, {}, false) )
end

function setLevel(x)
  if x > 1 then
    levels[levelNum].objs = objects
    levels[levelNum].plyrs = players
    levels[levelNum].camCols = cameraColliders
    levels[levelNum].endLvlTiles = endLevelTiles
    objects = {}
    players = {}
    enemies = {}
    cameraColliders = {}
    endLevelTiles = {}
    levelNum = x
    if x > levels[1] then
      levels[levelNum] = {objs = objects, plyrs = players, camCols = cameraColliders, enems = enemies, endLvlTiles = endLevelTiles }
      createPlayer()
      levels[1] = levels[1]+1
    else
      objects = levels[levelNum].objs
      players = levels[levelNum].plyrs
      cameraColliders = levels[levelNum].camCols
      endLevelTiles = levels[levelNum].endLvlTiles
      enemies = levels[levelNum].enems
    end
  end
end

function nextLevel()
  setLevel(levelNum + 1)
  for i=1, table.getn(players) do
    getPlayer(i).up = false
    getPlayer(i).right = false
    getPlayer(i).left = false
    getPlayer(i).down = false
  end
  if endLevelTiles == nil then
    endLevelTiles = {}
  end
end

function saveLevels()
  --table.save(levels,"levels/levels.txt")
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

    objects = levels[levelNum].objs
    cameraColliders = levels[levelNum].camCols
    enemies = levels[levelNum].enems
    players = levels[levelNum].plyrs
    
    if levels[levelNum].startx ~= nil then
      if getPlayer(1) ~= nil then
        getPlayer(1).x = levels[levelNum].startx
        getPlayer(1).y = levels[levelNum].starty
      end
      cameras[cameraNum].x = levels[levelNum].camx
      cameras[cameraNum].y = levels[levelNum].camy
    end
    
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
        if levels[i].plyrs[j].health == nil then
          levels[i].plyrs[j].health = 15
          levels[i].plyrs[j].damageTimer = 0
          levels[i].plyrs[j].alpha = 255
          levels[i].plyrs[j].flicker = 0
        end
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