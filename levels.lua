require('objects')
require('Tserial')
require('tablesave')

levels = {}
levelNum = 1
levels[0] = 1

function isempty(s)
  return s == nil
end

function levelsInit()
  levels[1] = {
    objs = objects,
    plyrs = players
  }
end

function setLevel(x)
  if x > 0 then
    levels[levelNum].objs = objects
    levels[levelNum].plyrs = players
    objects = {}
    players = {}
    levelNum = x
    if x > levels[0] then
      levels[levelNum] = {objs = objects, plyrs = {} }
      createPlayer()
      levels[0] = levels[0]+1
    else
      objects = levels[levelNum].objs
      players = levels[levelNum].plyrs
    end
  end
end

function saveLevels()
  --levels[levelNum].objs = objects
  --levels[levelNum].plyrs = players
  table.save(levels,"levels.txt")
end

function loadLevels()
  levels = {}
  levels = table.load("levels.txt")
  i = 1
  --print(table.getn(levels))
  while(i <= table.getn(levels)) do
    j = 1
    print(table.getn(levels[i].objs))
    while (j <= table.getn(levels[i].objs)) do
      print(Tserial.pack(levels[i].objs[j], "img = nil"))
      levels[i].objs[j].img = love.graphics.newImage(levels[i].objs[j].imagePath)
      if not isempty(levels[i].objs[j].id) then
        local playerNum = table.getn(players)+1
        --players[playerNum] = j
      end
      j=j+1
    end
    i = i+1
  end
  objects = {}
  objects = levels[levelNum].objs
end