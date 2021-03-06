--class to initializes Girlie instance

Girlie = Class{}

GIRLIE_IMAGE = love.graphics.newImage("Images/girlie.png")
GRAVITY = 12
JUMP = 150

-- Constructor to initialize girlie object
-- x, y = coordinates, dx, dy = horizontal and vertical velocities
function Girlie:init (x, y)
  self.x = x
  self.y = y
  self.dy = 0
  self.dx = 20
  self.width = GIRLIE_IMAGE:getWidth()
  self.height = GIRLIE_IMAGE:getHeight()
  self.obstructed = false
  self.score = 0
end

-- updates girlie character through call from main
function Girlie:update(dt)
  if self.obstructed == false then 
   if love.keyboard.wasPressed('right') then
    self.x = self.x + self.dx
   end
  
   if love.keyboard.wasPressed('left') then
    self.x = self.x - self.dx
   end

  
   if love.keyboard.wasPressed('up') then
    self.y = self.y - JUMP
   end
   
  
-- if girlie is in air, applies graviy 
-- otherwise resets her position to original ground
  if self.y < (VIRTUAL_H - GIRLIE_IMAGE:getHeight() - 10) then
    
  --checks if girlie is on a building, sets velocity to 0 if she is
       self.dy = self.dy + GRAVITY * dt 
       self.y = self.y + self.dy --normal fall condition if not on building
    else
      self.y = VIRTUAL_H - GIRLIE_IMAGE:getHeight()
      self.dy = 0
  end
  
--condition for girlie colliding with building and is pushed back
   else
      self.x = self.x -(CURRENT_BUILDING_SPEED * dt)
   end
 end



function Girlie:collide(building)
  if self.x + self.width - 50 > building.x and
     self.x + 50 < building.x + building.width then
       if self.y + self.height > building.y then
        return true
       else 
        return false
     end
  end
end

  
-- renders girlie on screen at x, y
function Girlie:render()
  love.graphics.draw(GIRLIE_IMAGE, self.x, self.y)
end
