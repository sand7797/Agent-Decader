import "CoreLibs/graphics"

function initSafe()
  background = gfx.image.new("images/safe/Jaeger.png")
  knob = gfx.image.new("images/safe/knob.png")
  safeCode = ""
  clockwise = 0
  moved = false
end

function safeUpdate()
  background:draw(0,0)

  local delta = playdate.getCrankChange() * 0.25
  --Rotation
  local newValue = safeCrankValue + delta
  if newValue > 360 then
    newValue = 0
  elseif newValue < 0 then
    newValue = 360
  end
  safeCrankValue = newValue
  knob:drawRotated(189,147,safeCrankValue)

  -- Værdi
  if math.abs(playdate.getCrankChange()) > 3 then 
    if playdate.getCrankChange() > 0 and clockwise <= 0 then
      clockwise = 1
      findSafeValue()
      moved = true
    elseif playdate.getCrankChange() < 0 and clockwise >= 0 then
      clockwise = -1
      findSafeValue()
      moved = true
    end
  end

end

function findSafeValue()
  if moved then
    if safeCrankValue >= 355 or safeCrankValue < 85 then
      safeCode = safeCode .. "C"
    elseif safeCrankValue >= 85 and safeCrankValue < 175 then
      safeCode = safeCode .. "3"
    elseif safeCrankValue >= 175 and safeCrankValue < 265 then
      safeCode = safeCode .. "6"
    elseif safeCrankValue >= 265 and safeCrankValue < 355 then
      safeCode = safeCode .. "9"
    end

    if #safeCode == 7 then
	safeCode = string.sub(safeCode, 2)
    end

    if safeCode == "39C369" then
	won = true
    end
  end
end
