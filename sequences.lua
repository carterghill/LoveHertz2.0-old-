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
    
    if getPlayer(1).x > 500 and not inSequence then
      inSequence = true
      seqTimer = 0
    end
    
    if inSequence then
      seqTimer = seqTimer + dt
      --walk right for 1 second
      if seqTimer < 1 then
        slowDown(getPlayer(1), dt)
      elseif seqTimer < 2 then
        displayDialog("Hello Joel!", dt)
        moveLeft(getPlayer(1), dt)
      elseif seqTimer < 2.25 then
        displayDialog("Hello Joel!", dt)
        slowDown(getPlayer(1), dt)
      elseif seqTimer < 6 then
        if seqTimer > 3.25 then
          displayDialog("This is a test cutscene.", dt)
        end
      elseif seqTimer < 9 then
        if seqTimer > 6.25 then
          displayDialog("Okay back to game now bye", dt)
        end
      else
        -- When done, end sequence and remove it
        inSequence = false
        table.remove(sequences[1], index)
      end
    end
    
  end
end

function sequence(dt)
  if sequences[levelNum] ~= nil then
    for i = 1, table.getn(sequences[levelNum]) do
      seq = sequences[levelNum][i]
      seq:action(i, dt)
    end
  end
end