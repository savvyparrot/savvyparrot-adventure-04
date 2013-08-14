((root, targetNS, localName, savvy, cjs) ->

  root[targetNS][localName] = (mode, startPosition, doLoop) ->
    @initialize(mode, startPosition, doLoop, {})

    welcomeSound = () ->
      cjs.Sound.play('sound-pepi', cjs.Sound.INTERRUPT_EARLY, 0, 0, undefined)
      return

    TIME_PEPI_ENTRANCE    = 16
    TIME_WELCOME = TIME_PEPI_ENTRANCE + 31

    @timeline.addTween(cjs.Tween.get(this).wait(TIME_WELCOME).call(welcomeSound).wait(40))

    bubble = new savvy.Bubble("synched", 0, "Hola Kids!\nBienvenido a mi isla! Aawk!!", "#33FF66")
    bubble.setTransform(684,167.5,1,1,0,0,0,216,92.5)
    bubble._off = true
    bubbleTween = cjs.Tween.get(bubble)
    bubbleTween.wait(TIME_WELCOME)
    bubbleTween.to({"startPosition": 0, "_off": false}, 0)
    bubbleTween.wait(50)
    bubbleTween.to({"_off": true}, 0)
    @timeline.addTween(bubbleTween)

    pepi = new savvy.Pepi()
    pepi.setTransform(-253.9,428.1,1,1,0,0,0,224.5,331.2)
    pepi._off = true
    pepiTween = cjs.Tween.get(pepi)
    # The following is Pepi moving into position on the stage.
    pepiTween.wait(TIME_PEPI_ENTRANCE).to({'_off': false}, 0)
    x = -238.4
    y =  426.9
    for i in [0..31]
      args = {"x": x, "y": y}
      pepiTween.wait(1).to(args, 0)
      x += 14.932258
      y -= 1.15483871
    @timeline.addTween(pepiTween)

    island = new savvy.Island()
    island.setTransform(525.5,384.4,1,1,0,0,0,525.5,384.4)
    islandTween = cjs.Tween.get(island)
    islandTween.wait(1).to({regX:512,regY:384,scaleX:1.09,scaleY:1.09,x:542.6,y:391.5,alpha:0.98}, 0)
    @timeline.addTween(islandTween)
    return

  root[targetNS][localName].prototype = new cjs.MovieClip()
  root[targetNS][localName].prototype.nominalBounds = new cjs.Rectangle(0,0,1024,768)
  return

)(this, "SavvyParrot", "Adventure04Lesson001", SavvyParrot, createjs)
