require('mouse') -- Handles all mouse actions
require('camera')
require('levels/objects')
require('levels/levels')
require('entities/enemy')
require('entities/player')
require('controls')
require('sequences')
require('levels/endLevel')
require('UI/UI')
editMode = true

function love.load()

  getPlaceables()
  seqInit()
  dialInit()
  levelsInit()
  background = love.graphics.newImage("80's+City.jpg")
  newPlaceable("images/tiles/noCamera.png", "Camera Collider")
	newCamera()
  createPlayer()
  loadUI()

end

words = ""
function love.draw()

  love.graphics.draw(background,0,0,0,0.5)
	drawObjects()
	drawUI()
  drawDialog()
end


function love.update(dt)

  updateUI()
  endLevel() -- Checks whether the player has hit the endLevel tile
  onDeath() -- Checks if player 1's health is 0

  if love.keyboard.isDown("f") then
    dt = dt/5
  end
  
	if editMode then
		mouseCheck()
	end
	
	if table.getn(players) > 0 then
		lockOn(players[1], dt)
	end

	if not editMode then
    enemyUpdate(dt)
		playerUpdate(dt)
    bulletUpdate(dt)
    --if not inSequence then
      --checkControls()
    --end
	end
  sequence(dt)
	camera(dt)
end

function love.mousepressed(x, y, button)
  if button == 1 and not editMode then
    shoot(1)
  end
end
