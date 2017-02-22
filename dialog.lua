dialogs = {}

function newDialog(text, dx, dy, sc, thing)
  local num = table.getn(dialogs)+1
  dialogs[num] = {
    dialogTimer = 0,
    targetDialog = text,
    dialog = " ",
    showDialog = false,
    x = dx,
    y = dy, 
    scale = sc,
    posType = thing
  }
  if dialogs[num].x == nil then
    dialogs[num].x = love.graphics.getWidth()*0.25
    dialogs[num].y = love.graphics.getHeight()*0.74
  end
  if dialogs[num].scale == nil then
    dialogs[num].scale = 1
  end
  if dialogs[num].posType == nil or dialogs[num].posType == "Absolute" then
  
  elseif dialogs[num].posType == "Relative" then
    --dialogs[num].x = getx(dialogs[num])
    --dialogs[num].y = gety(dialogs[num])
  end
    
  return num
end

function dialInit()
  font = love.graphics.newFont("DroidSans.ttf", 30)
  textBanner = love.graphics.newImage('images/textBanner.png')
  sound = love.audio.newSource("textblip.wav", "static")
end

function displayDialog(dia, dt)
  dia.showDialog = true
  
  dia.dialogTimer = dia.dialogTimer + dt
  if dia.dialogTimer > 0.1 then
    if string.len(dia.dialog) <= string.len(dia.targetDialog) and string.len(dia.targetDialog) > 0 then
      sound:play()
      local temp = dia.targetDialog
      -- Get the character at dialog length from the target dialog
      temp = temp:sub(string.len(dia.dialog), string.len(dia.dialog))
      if temp == " " then
        temp = temp..dia.targetDialog:sub(string.len(dia.dialog)+1, string.len(dia.dialog)+1)
      end
      -- Concatenate it to the dialog being displayed
      if dia.dialog ~= " " then
        dia.dialog = dia.dialog ..temp
      else
        dia.dialog = "~"..temp
      end
      
      width, wrappedtext = font:getWrap( dia.dialog, 620)
      if table.getn(wrappedtext) > 4 then
        if love.keyboard.isDown('space') then
          dia.targetDialog = dia.targetDialog:sub(string.len(dia.dialog)-1, string.len(dia.targetDialog))
          dia.dialog = "~"
        else
          dia.dialog = dia.dialog:sub(1, -2)
          sound:stop()
        end
      end
    end
    dia.dialogTimer = 0
  end
  
end

function dialogOver(dia)
  
  if dia.dialog == "~"..dia.targetDialog and love.keyboard.isDown("space") then
    return true
  else
    return false
  end

end

function drawDialog()
  for i = 1, table.getn(dialogs) do
    if dialogs[i].showDialog then
      love.graphics.setFont(font)
      dialogs[i].showDialog = false
      
      if dialogs[i].posType == "Relative" then
        love.graphics.draw(textBanner, getx(dialogs[i]), gety(dialogs[i]), 0, 0.5*dialogs[i].scale)
        love.graphics.printf(dialogs[i].dialog, getx(dialogs[i])+16*dialogs[i].scale, gety(dialogs[i])+16*dialogs[i].scale, 620, "left", 0, dialogs[i].scale)
      else
        love.graphics.draw(textBanner, dialogs[i].x, dialogs[i].y, 0, 0.5*dialogs[i].scale)
        love.graphics.printf(dialogs[i].dialog, dialogs[i].x+16*dialogs[i].scale, dialogs[i].y+16*dialogs[i].scale, 620, "left", 0, dialogs[i].scale)
      end
      love.graphics.setNewFont(16)
    end
  end
end