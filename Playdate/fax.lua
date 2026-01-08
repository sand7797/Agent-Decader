import "CoreLibs/graphics"
import "CoreLibs/animation"
import "globals"

function initFax()
  stillImage = gfx.image.new("images/radiofax/radiofaxstill.png")
  printImage = gfx.image.new("images/radiofax/faxfilled.png")
  animSheet = gfx.imagetable.new("images/radiofax/radiofax.gif")
  fax1 = gfx.image.new("images/radiofax/fax1.png")
  fax2 = gfx.image.new("images/radiofax/fax2.png")
  faxAnim = gfx.animation.loop.new(50,animSheet,false)
	print(faxStatus.current)
	print(faxStatus.ran)
	print(faxStatus.enabled)
  delay = true
end

function faxUpdate()
  if faxStatus.enabled then

    if delay and not faxStatus.ran then
      playdate.timer.updateTimers()
      playdate.timer.new(2000, function()
	faxStatus.ran = true
	delay = false
      end)
    end

    if playdate.buttonIsPressed(playdate.kButtonA) then
      if faxStatus.current == 1 then
	fax1:draw(0,0)
      elseif faxStatus.current == 2 then
	fax2:draw(0,0)
      end
    elseif faxStatus.ran then
      printImage:draw(0,0); 
    else 
      faxAnim:draw(0,0); 
    end
  else
    stillImage:draw(0,0)
  end 
end

