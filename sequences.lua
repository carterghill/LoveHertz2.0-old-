require('dialog')
-- Sequences will be a 2D array, with the first index representing the level number
-- Shouldn't be checking the sequences in a level that isn't in play
sequences = {{}}
sequenceNum = 1
inSequence = false
seqTimer = 0

function seqInit()
  sequences[1][1] = {
    x = 300,
    y = 0
  }
  
  --------------------
  -- Level 1: Scene 1
  --------------------
  
  seq = sequences[1][1]
  function seq:action(index, dt)
    
    if getPlayer(1) ~= nil and getPlayer(1).x > 500 and not inSequence then
      inSequence = true
      seqTimer = 0
    end
    
    if inSequence then
      if love.keyboard.isDown("space") then
        dt = dt*5
      end
      seqTimer = seqTimer + dt
      --walk right for 1 second
      if seqTimer < 1 then
        slowDown(getPlayer(1), dt)
      elseif seqTimer < 2 then
        displayDialog("Hello Joel! This is a test cutscene, and a test for text wrap in dialog. You can speed it up by holding space. You also have to hold space to close the text when its done.", dt)
        moveLeft(getPlayer(1), dt)
      elseif seqTimer < 2.25 then
        displayDialog("Hello Joel! This is a test cutscene, and a test for text wrap in dialog. You can speed it up by holding space. You also have to hold space to close the text when its done.", dt)
        slowDown(getPlayer(1), dt)
      elseif not dialogOver() then
        displayDialog("Hello Joel! This is a test cutscene, and a test for text wrap in dialog. You can speed it up by holding space. You also have to hold space to close the text when its done.", dt)
      else
        -- When done, end sequence and remove it
        inSequence = false
        table.remove(sequences[1], index)
      end 
    end
    
  end
end

function sequence(dt)
  if sequences[levelNum-1] ~= nil then
    for i = 1, table.getn(sequences[levelNum-1]) do
      seq = sequences[levelNum-1][i]
      seq:action(i, dt)
    end
  end
end