import "CoreLibs/graphics"
import "CoreLibs/animation"
import "globals"

faxStatus = {current = 1, enabled = true, ran = false}
function initFax()
  stillImage = gfx.image.new("images/radiofax/radiofaxstill.png")
  printImage = gfx.image.new("images/radiofax/faxfilled.png")
  animSheet = gfx.imagetable.new("images/radiofax/radiofax.gif")
  fax1 = gfx.image.new("images/radiofax/fax1.png")
  faxAnim = gfx.animation.loop.new(50,animSheet,false)
end

function faxUpdate()
  if faxStatus.enabled then
    if faxStatus.ran then
      printImage:draw(0,0); 
    else 
      faxAnim:draw(0,0); 
    end
  else
    stillImage:draw(0,0)
  end 
  playdate.timer.updateTimers()
  playdate.timer.performAfterDelay(2000, function()
    faxStatus.ran = true
  end)
end

