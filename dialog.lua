dialogTimer = 0
showDialog = false
dialog = ""
targetDialog = ""
dialogx = 0
dialogy = love.graphics.getHeight()*0.75

function dialInit()
  font = love.graphics.newFont("DroidSans.ttf", 30)
  textBanner = love.graphics.newImage('images/textBanner.png')
  sound = love.audio.newSource("textblip.wav", "static")
end

function displayDialog(text, dt)
  showDialog = true
  if targetDialog ~= text then
    targetDialog = text
    dialog = " "
    dialogTimer = 0
  else
    
    dialogTimer = dialogTimer + dt
    if dialogTimer > 0.1 then
      if string.len(dialog) <= string.len(targetDialog) and string.len(targetDialog) > 0 then
        sound:play()
        local temp = targetDialog
        -- Get the character at dialog length from the target dialog
        temp = temp:sub(string.len(dialog), string.len(dialog))
        if temp == " " then
          temp = temp..targetDialog:sub(string.len(dialog)+1, string.len(dialog)+1)
        end
        -- Concatenate it to the dialog being displayed
        if dialog ~= " " then
          dialog = dialog ..temp
        else
          dialog = "~"..temp
        end
      end
      dialogTimer = 0
    end
  end

end

function dialogOver()
  
  if dialog == "~"..targetDialog and love.keyboard.isDown("space") then
    return true
  else
    return false
  end

end

function drawDialog()
  if showDialog then
    love.graphics.setFont(font)
    showDialog = false
    local y = love.graphics.getHeight()*0.74
    local x = love.graphics.getWidth()*0.25
    love.graphics.draw(textBanner, x, y, 0, 0.5)
    love.graphics.printf(dialog, x+16, y+16, x+textBanner:getWidth()*0.25-48, "left")
    love.graphics.setNewFont(16)
  end
end