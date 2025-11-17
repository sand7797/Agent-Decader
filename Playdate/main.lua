-- Import libs
import "CoreLibs/graphics"
import "globals"
import "icons"

-- Init vars
gfx = playdate.graphics
sfx = playdate.sound
roomindex = 1
radioCrankValue = 210
sceneManagerEnabled = true
import "morse"
import "phone"
import "radio"

-- Mode options
modes = {"phone", "radio", "morse"}
function init()
  if mode == "radio" then
    initRadio()
  elseif mode == "phone" then
    initPhone()
  elseif mode == "morse" then
    initMorse()
  end
end
init()

function playdate.update()
  sceneManager()
  gfx.setColor(gfx.kColorBlack)
  gfx.fillRect(0, 0, 400, 240)
  -- If radio
  if mode == "radio" then
    radioUpdate()
  elseif mode == "phone" then
    phoneUpdate()
  elseif mode == "morse" then
    morseUpdate()
  end
  --dPad.LR:draw(350, 200)
end

function sceneManager()
  if sceneManagerEnabled then
    if playdate.buttonJustPressed(playdate.kButtonLeft) or playdate.buttonJustPressed(playdate.kButtonRight) then
      if playdate.buttonJustPressed(playdate.kButtonLeft) then
	roomindex = roomindex - 1
      elseif playdate.buttonJustPressed(playdate.kButtonRight) then
	roomindex = roomindex + 1
      end

      if roomindex < 1 then roomindex = 1 end
      if roomindex > 3 then roomindex = 3 end
      mode = modes[roomindex]
      init()
    end
  end
end
