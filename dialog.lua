dialogTimer = 0
showDialog = false
dialog = ""
targetDialog = ""
dialogx = 0
dialogy = love.graphics.getHeight()*0.75

function dialInit()
  font = love.graphics.newFont("bitfont.ttf", 28)
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
        local temp = targetDialog
        -- Get the character at dialog length from the target dialog
        temp = temp:sub(string.len(dialog), string.len(dialog))
        if temp == " " then
          temp = temp..targetDialog:sub(string.len(dialog)+1, string.len(dialog)+1)
        end
        -- Concatenate it to the dialog being displayed
        dialog = dialog ..temp
      end
      dialogTimer = 0
    end
  end

end


function drawDialog()
  if showDialog then
    love.graphics.setFont(font)
    love.graphics.print(dialog, 30, dialogy)
    showDialog = false
    love.graphics.setNewFont(16)
  end
end