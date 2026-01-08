-- Import libs
import "CoreLibs/graphics"
import "CoreLibs/timer"
import "globals"
import "icons"

-- Init vars
won = false
gfx = playdate.graphics
sfx = playdate.sound
roomindex = 1
sceneManagerEnabled = true
endGame = gfx.image.new("images/endgame.png")
import "morse"
import "phone"
import "radio"
import "fax"
import "safe"

-- Mode options
modes = {"safe", "phone", "radio", "morse", "fax"}
function init()
  if mode == "radio" then
    initRadio()
  elseif mode == "phone" then
    initPhone()
  elseif mode == "morse" then
    initMorse()
  elseif mode == "fax" then
    initFax()
  elseif mode == "safe" then
    initSafe()
  end
end
init()

function playdate.update()
  sceneManager()
  gfx.setColor(gfx.kColorBlack)
  gfx.fillRect(0, 0, 400, 240)
  -- If radio
  if not won then
    if mode == "radio" then
      radioUpdate()
    elseif mode == "phone" then
      phoneUpdate()
    elseif mode == "morse" then
      morseUpdate()
    elseif mode == "fax" then
      faxUpdate()
    elseif mode == "safe" then
      safeUpdate()
    end
  else
    endGame:draw(0,0)
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
      if roomindex > 5 then roomindex = 5 end
      mode = modes[roomindex]
      init()
    end
  end
end
