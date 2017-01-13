require('objects')
require('Tserial')
require('tablesave')

levels = {}

function levelsInit()
  levels[1] = {objs = objects }
end

function saveLevels()
  table.save(levels,"levels.txt")
end

function loadLevels()
  levels = {}
  levels = table.load("levels.txt")
  i = 1
  print(table.getn(levels))
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
  objects = levels[1].objs
end