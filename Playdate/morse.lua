import "CoreLibs/graphics"

function initMorse()
  backgroundUp = gfx.image.new("images/morse/Morse_coder_up.png")
  backgroundDown = gfx.image.new("images/morse/Morse_coder_down.png")
  tone = sfx.synth.new(sfx.kWaveSine)
end

function morseUpdate()
  if playdate.buttonIsPressed(playdate.kButtonA) or playdate.buttonIsPressed(playdate.kButtonDown) then
    sceneManagerEnabled = false
    backgroundDown:draw(0,100)
    tone:playNote(850)
  else
    backgroundUp:draw(0,100)
    if tone:isPlaying() then
      tone:stop()
    end
    sceneManagerEnabled = true
  end
end

