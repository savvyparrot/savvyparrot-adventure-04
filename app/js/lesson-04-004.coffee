((root, targetNS, localName, savvy, cjs) ->

  root[targetNS][localName] = (mode, startPosition, doLoop) ->
    @initialize(mode, startPosition, doLoop, {})

    FarmMovieClip = (mode, startPosition, doLoop) ->
      @initialize(mode, startPosition, doLoop, {})

      farm0 = new SavvyParrot.Farm("synched", 0)
      farm0.setTransform(97, 20.1)
      farm0.alpha = 1.0

      farm1 = new SavvyParrot.Farm("synched", 0)
      farm1.setTransform(512,384)
      farm1.alpha = 0.25

      # In this case we don't specify a target.
      tween = cjs.Tween.get({})
      tween.to({"state": [{"t": farm0}]}, 0)
      tween.to({"state": [{"t": farm1}]}, 24)
      # The event listener continues to be called long after the animation ceases!
      # tween.addEventListener("change", (event) -> console.log "changed!")
      # tween.wait(1) // This seems to be the cause of the flashing; I don't know why!
      @timeline.addTween(tween)
      return
    FarmMovieClip.prototype = new cjs.MovieClip()
    FarmMovieClip.prototype.nominalBounds = new cjs.Rectangle(-414.9,-363.9,1024,768)

    islandZoomInToBarn = () ->
      island = new SavvyParrot.Island()
      island.setTransform(525.5,384.4,1,1,0,0,0,525.5,384.4)
      tween = cjs.Tween.get(island)

      tween.wait(1).to({regX:512,regY:384,scaleX:1.09,scaleY:1.09,x:542.6,y:391.5,alpha:0.98},0)
      scale = 1.18
      x = 573.2
      y = 399.0
      alpha = 0.959
      for i in [0..31]
        args = {'scaleX': scale, 'scaleY': scale, 'x':x, 'y': y, 'alpha': alpha}
        tween.wait(1).to(args, 0)
        scale += 0.0909677
        x += 30.5935
        y += 7.47096
        alpha -= 0.020387

      for i in [0..11]
        args = {'alpha': alpha}
        tween.wait(1).to(args, 0)
        alpha -= 0.02
      tween.to({_off:true},1)
      return tween

    showFarm = () ->
      farmMovieClip = new FarmMovieClip()
      farmMovieClip.setTransform(961,812.9,1,1,0,0,0,546,448.9)
      farmMovieClip.alpha = 0
      farmMovieClip._off = true

      tween = cjs.Tween.get(farmMovieClip)
      tween.wait(34)
      tween.to({_off:false},0)
      tween.to({alpha:1},24)
      tween.wait(10)
      tween.to({alpha:0.211},20)
      tween.wait(72)
      return tween

    enterPepiStageLeft = () ->
      pepi = new SavvyParrot.Pepi()
      pepi.setTransform(-253.9,428.1,1,1,0,0,0,224.5,331.2)
      pepi._off = true
      tween = cjs.Tween.get(pepi)
      tween.wait(88).to({_off:false},0).wait(1).to({x:-238.4,y:426.9},0).wait(1).to({x:-222.9,y:425.7},0).wait(1).to({x:-207.5,y:424.5},0).wait(1).to({x:-192.1,y:423.3},0).wait(1).to({x:-176.6,y:422.1},0).wait(1).to({x:-161.2,y:420.9},0).wait(1).to({x:-145.8,y:419.7},0).wait(1).to({x:-130.3,y:418.5},0).wait(1).to({x:-114.9,y:417.3},0).wait(1).to({x:-99.4,y:416.1},0).wait(1).to({x:-84,y:414.9},0).wait(1).to({x:-68.6,y:413.7},0).wait(1).to({x:-53.1,y:412.5},0).wait(1).to({x:-37.7,y:411.3},0).wait(1).to({x:-22.3,y:410.1},0).wait(1).to({x:-6.8,y:409},0).wait(1).to({x:8.5,y:407.8},0).wait(1).to({x:23.9,y:406.6},0).wait(1).to({x:39.3,y:405.4},0).wait(1).to({x:54.8,y:404.2},0).wait(1).to({x:70.2,y:403},0).wait(1).to({x:85.6,y:401.8},0).wait(1).to({x:101.1,y:400.6},0).wait(1).to({x:116.5,y:399.4},0).wait(1).to({x:131.9,y:398.2},0).wait(1).to({x:147.4,y:397},0).wait(1).to({x:162.8,y:395.8},0).wait(1).to({x:178.2,y:394.6},0).wait(1).to({x:193.7,y:393.4},0).wait(1).to({x:209.1,y:392.2},0).wait(1).to({x:224.5,y:391.1},0).wait(41)
      return tween

    showBubble = (text) ->
      bubble = new SavvyParrot.Bubble("synched", 0, text, "#33FF66")
      bubble.setTransform(684, 167.5, 1, 1, 0, 0, 0, 216, 92.5)
      bubble._off = true
      tween = cjs.Tween.get bubble
      tween.wait(119).to({startPosition:0,_off:false}, 0)
      return tween

    playBubble = (target, soundId) ->
      
      welcomeSoundClip = () ->
        createjs.Sound.play(soundId, createjs.Sound.INTERRUPT_EARLY, 0, 0, undefined)

      tween = cjs.Tween.get(target).wait(119).call(welcomeSoundClip).wait(40)
      return tween


    # Objects which appear first are drawn on top.
    # Can we make it more linear and change the z-order?
    @timeline.addTween enterPepiStageLeft()

    @timeline.addTween showBubble("Hello Kids!\nWelcome to my island!")
    @timeline.addTween playBubble(@, 'sound-pepi')

    @timeline.addTween showFarm()

    @timeline.addTween islandZoomInToBarn()

    return

  root[targetNS][localName].prototype = new cjs.MovieClip()
  root[targetNS][localName].prototype.nominalBounds = new cjs.Rectangle(0,0,1024,768)
  return

)(this, "SavvyParrot", "Adventure04Lesson004", SavvyParrot, createjs)