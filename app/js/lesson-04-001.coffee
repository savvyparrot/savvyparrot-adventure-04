((root, targetNS, localName, sp, cj) ->

  root[targetNS][localName] = (mode, startPosition, doLoop) ->
    @initialize(mode, startPosition, doLoop, {})

    TIME_PEPI_ENTRANCE = 16
    TIME_PEPI_ON_STAGE = TIME_PEPI_ENTRANCE + 31

    translate = (target, startTime, startPoint, endTime, endPoint) ->
      target.setTransform(startPoint.x, startPoint.y, 1, 1, 0, 0, 0, 0, 0)
      target._off = false
      tween = cj.Tween.get(target)
      tween.wait(startTime).to({'_off': false}, 0)
      duration = endTime - startTime
      x = startPoint.x
      y = startPoint.y
      dx = (endPoint.x - startPoint.x) / duration
      dy = (endPoint.y - startPoint.y) / duration
      for i in [1..duration]
        x += dx
        y += dy
        tween.wait(1).to({"x": x, "y": y}, 0)
      return tween

    welcomeSound = () ->
      cj.Sound.play('sound-pepi', cj.Sound.INTERRUPT_EARLY, 0, 0, undefined)
      return

    pepi = new sp.Pepi()
    @timeline.addTween translate pepi, TIME_PEPI_ENTRANCE, new cj.Point(-450, -100), TIME_PEPI_ON_STAGE, new cj.Point(-110, 110)

    @timeline.addTween(cj.Tween.get(this).wait(TIME_PEPI_ON_STAGE).call(welcomeSound))

    bubble = new sp.Bubble("synched", 0, "Hello Kids!\nWelcome to my island!", "#33FF66")
    bubble.setTransform(684,167.5,1,1,0,0,0,216,92.5)
    bubble._off = true
    bubbleTween = cj.Tween.get(bubble)
    bubbleTween.wait(TIME_PEPI_ON_STAGE)
    bubbleTween.to({"startPosition": 0, "_off": false}, 0)
    bubbleTween.wait(50)
    bubbleTween.to({"_off": true}, 0)
    @timeline.addTween(bubbleTween)

    # All of the magic numbers have been taken out of the Island.
    island = new sp.Island()
    #island.setTransform(0, 0, 1, 1, 0, 0, 0, 0, 0)
    islandTween = cj.Tween.get(island)
    #islandTween.wait(0).to({regX:0,regY:0,scaleX:1,scaleY:1,x:0,y:0,alpha:1}, 0)
    @timeline.addTween(islandTween)
    return

  root[targetNS][localName].prototype = new cj.MovieClip()
  root[targetNS][localName].prototype.nominalBounds = new cj.Rectangle(0, 0, 1024, 768)
  return

)(this, "SavvyParrot", "Adventure04Lesson001", SavvyParrot, createjs)
