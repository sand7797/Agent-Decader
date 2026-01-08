import "CoreLibs/graphics"
import "globals"
import "phoneTriggers"

failSound = sfx.sampleplayer.new("audio/phone.wav")
rotReturnSound = sfx.sampleplayer.new("audio/dial2.wav")
rotReturnEndSound = sfx.sampleplayer.new("audio/endDial.wav")

function initPhone()
  pickedUp = false
  currentNumber = nil
  phoneNumber = ""
  numberChecked = false
  isPhone = true
  isReturning = false
  dialSoundPlaying = false
  endSoundPlayed = true
  background = gfx.image.new("images/phone/empty.png")
  backgroundPicked = gfx.image.new("images/phone/picked_up.png")
  foreground = gfx.image.new("images/phone/top.png")
  dial = gfx.image.new("images/phone/dial2.png")
  crankValue = 359
  minValue = 359
  maxValue = 43
  newValue = crankValue

  phoneWait = 1

  phoneCall0 = sfx.fileplayer.new("audio/phone1.mp3")
  phoneCall1 = sfx.fileplayer.new("audio/phone2.mp3")
  phoneCall2 = sfx.fileplayer.new("audio/phone3.mp3")
end

function playdate.cranked(change)
  if mode == "phone" and change ~= nil and not isReturning then
    if change < -1.5 then
      playdate.resetElapsedTime()
    end
  end
end


function phoneUpdate()
  if isReturning then
    sceneManagerEnabled = false
  else
    sceneManagerEnabled = true
  end
  if not pickedUp then
    -- Movement delta
    if not isReturning then
      delta = playdate.getCrankChange()
    else
      delta = 0
      isReturning = false
    end
    -- Change
    if delta < 0 then
      --To prevent minor movement jank
      if newValue > minValue - 10 then
	if delta < -2.5 then
	newValue = crankValue + delta
	end
      else
	newValue = crankValue + delta
      end
      --To prevent small movement jank
    end
    -- If at start
    if newValue == minValue then
      numberChecked=false
      dialSoundPlaying = false
      rotReturnSound:stop()
      if not endSoundPlayed then
	rotReturnEndSound:play()
	endSoundPlayed = true
      end
    end
    -- Return
    if delta >= 0 and newValue ~= minValue then
      if playdate.getElapsedTime() > 0.5 then
	isReturning = true
	if not numberChecked then
	  getTrigger(newValue, triggerPoints)
	end
	playDialSound()
	newValue = newValue + 7
      end
    end
    -- Check if 0
    if newValue == 0 then
      isReturning = false
    end
    -- Clamp value
    if newValue > minValue then
	newValue = minValue
    elseif newValue < maxValue then
	newValue = maxValue
    end
    crankValue = newValue

    background:draw(0,0)
    dial:drawRotated(207,135,crankValue)
    foreground:draw(0,0)


    --pickup phone
    if playdate.buttonJustPressed(playdate.kButtonUp) and not pickedUp then
      if phoneNumber == "148842" then
	phoneCall0:play()
	if faxStatus.current == 1 then
	  faxStatus.enabled = true
	end
	phoneWait = 65
      elseif phoneNumber == "204511" then
	phoneWait = 81
	phoneCall1:play()
      elseif phoneNumber == "364467" then
	phoneWait = 113
	phoneCall2:play()
	faxStatus.current = 2
	faxStatus.ran = false
      else
	failSound:play() 
	phoneWait = 11.5
      end
      pickedUp = true;
      phoneNumber = ""
      playdate.resetElapsedTime()
    end
  end

    --if picked
  if pickedUp then
    backgroundPicked:draw(0,0)
    sceneManagerEnabled = false
    if playdate.getElapsedTime() > phoneWait then
      sceneManagerEnabled = true
      pickedUp = false
    end
  end
end

function playDialSound() 
  if not dialSoundPlaying then
    rotReturnSound:play()
    dialSoundPlaying = true
    endSoundPlayed = false
  end
end

function getTrigger(num, triggers)
  for i = 0, 9 do
    if num < triggers[10] then
      currentNumber = 0
      break
    elseif num > triggers[i+1] then
      currentNumber = triggerPointValues[i]
      break
    end
  end
  numberChecked = true
  if currentNumber ~= nill then
    phoneNumber = phoneNumber .. currentNumber 
  end
  print(phoneNumber)
end
