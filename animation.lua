function newAnim(dir, sp)
  
  local this = {
    index = 1,
    animation = {},
    speed = sp,
    time = 0
  }
  
  local files = love.filesystem.getDirectoryItems(dir)
  for k, file in ipairs(files) do
    this.animation[#(this.animation)+1 ] = love.graphics.newImage(dir.."/"..file)
    --print(
  end
  
  function this:animate(dt)
    self.time = self.time + dt
    if self.time > self.speed then
      print("animation frame: "..tostring(self.index))
      self.time = 0
      self.index = self.index + 1
      if self.index > #self.animation then
        self.index = 1
      end
    end
  end
  
  function this:getFrame()
    return self.animation[self.index]
  end
  
  return this
  
end