dialogTimer = 0
showDialog = false
dialog = ""
dialogx = 0
dialogy = love.graphics.getHeight()*0.75

function dialInit()
  font = love.graphics.newFont("bitfont.ttf", 26)
end

function displayDialog(text, dt)
  showDialog = true
  dialog = text

end

function drawDialog()
  if showDialog then
    love.graphics.setFont(font)
    love.graphics.print(dialog, 30, dialogy)
    showDialog = false
    love.graphics.setNewFont(16)
  end
end