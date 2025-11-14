import "CoreLibs/graphics"

function initRadio()
    background = gfx.image.new("images/radio.png")
    knob = gfx.image.new("images/knob.png")
    crankValue = 210
    minValue = 70
    maxValue = 360
end

function radioUpdate()
  -- Movement delta
  local delta = playdate.getCrankChange()
  -- Change
  local newValue = crankValue + delta
  -- Clamp value
  if newValue < minValue then
      newValue = minValue
  elseif newValue > maxValue then
      newValue = maxValue
  end
  crankValue = newValue

  -- Pointer Line
  gfx.setColor(gfx.kColorWhite)
  local norm = normalize(crankValue,40,370,137,252)
  gfx.setLineWidth(3)
  gfx.drawLine(196,191,norm,(0.0062 * norm ^ 2) - (2.45 * norm) + 330)
  -- RadioBG
  background:draw(0,0)
  -- Knob
  knob:drawRotated(230,180,crankValue)
end

-- Norm func
function normalize(x, a, b, c, d)
    return c + (x - a) * (d - c) / (b - a)
end

