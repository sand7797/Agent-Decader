-- Import libs
import "CoreLibs/graphics"
import "radio"

-- Init vars
gfx = playdate.graphics
local mode = "radio"

-- Mode options
if mode == "radio" then
  initRadio()
end

function playdate.update()
  gfx.setColor(gfx.kColorBlack)
  gfx.fillRect(0, 0, 400, 240)
  -- If radio
  if mode == "radio" then
    radioUpdate()
  end
end

