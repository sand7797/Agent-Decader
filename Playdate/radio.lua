import "CoreLibs/graphics"
function initRadio()
  radioStatic = sfx.sampleplayer.new("audio/static.wav")
  background = gfx.image.new("images/radio.png")
  knob = gfx.image.new("images/knob.png")
  minValue = 70
  maxValue = 360
  radio1 = playdate.sound.fileplayer.new("audio/radio1.mp3")
end

function radioUpdate()
  -- Movement delta
  local delta = playdate.getCrankChange() * 0.25
  -- Change
  local newValue = radioCrankValue + delta
  -- Clamp value
  if newValue < minValue then
      newValue = minValue
  elseif newValue > maxValue then
      newValue = maxValue
  end
  radioCrankValue = newValue

  -- Pointer Line
  gfx.setColor(gfx.kColorWhite)
  local norm = normalize(radioCrankValue,40,370,137,252)
  gfx.setLineWidth(3)
  gfx.drawLine(196,191,norm,(0.0062 * norm ^ 2) - (2.45 * norm) + 330)
  -- RadioBG
  background:draw(0,0)
  -- Knob
  knob:drawRotated(230,180,radioCrankValue)

  -- Text
  gfx.setImageDrawMode(gfx.kDrawModeInverted)
  gfx.drawTextAligned(tostring(math.floor(radioCrankValue)) .. " kHz", 200, 10, kTextAlignment.center)
  gfx.setImageDrawMode(gfx.kDrawModeCopy)

  if playdate.buttonIsPressed(playdate.kButtonA) then
    if not radioStatic:isPlaying() then
      -- TILFØJ SIDSTE RADIODISAMTALER
    if math.floor(radioCrankValue) == 97 and not hasRadioPlayed then
	hasRadioPlayed = true
	radio1:play()
      else
	radioStatic:play()
      end
    end
  end

end

-- Norm func
function normalize(x, a, b, c, d)
    return c + (x - a) * (d - c) / (b - a)
end
