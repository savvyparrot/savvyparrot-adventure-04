((root, targetNS, localName, sp, cj) ->

  root[targetNS][localName] = (mode, startPosition, doLoop) ->
    @initialize(mode, startPosition, doLoop, {})

    DURATION_FADE_ISLAND = 24
    DURATION_SHOW_ISLAND = 12
    DURATION_ZOOM_ISLAND_TO_FARM = 48
    DURATION_SWAP_ISLAND_TO_FARM = 24
    DURATION_PEPI_ENTRANCE = 32

    TIME_BEGIN_FADE_ISLAND = 0
    TIME_END_FADE_ISLAND = TIME_BEGIN_FADE_ISLAND + DURATION_FADE_ISLAND

    TIME_BEGIN_SHOW_ISLAND = TIME_END_FADE_ISLAND
    TIME_END_SHOW_ISLAND = TIME_BEGIN_SHOW_ISLAND + DURATION_SHOW_ISLAND

    TIME_BEGIN_ZOOM_ISLAND_TO_FARM = TIME_END_SHOW_ISLAND
    TIME_END_ZOOM_ISLAND_TO_FARM = TIME_BEGIN_ZOOM_ISLAND_TO_FARM + DURATION_ZOOM_ISLAND_TO_FARM

    TIME_BEGIN_SWAP_ISLAND_TO_FARM = TIME_END_ZOOM_ISLAND_TO_FARM
    TIME_END_SWAP_ISLAND_TO_FARM = TIME_BEGIN_SWAP_ISLAND_TO_FARM + DURATION_SWAP_ISLAND_TO_FARM

    TIME_BEGIN_PEPI_ENTRANCE = TIME_END_SWAP_ISLAND_TO_FARM
    TIME_END_PEPI_ENTRANCE = TIME_BEGIN_PEPI_ENTRANCE + DURATION_PEPI_ENTRANCE

    TIME_BEGIN_PEPI_WELCOME = TIME_END_PEPI_ENTRANCE

    islandArrival = (island) ->
      tween = cj.Tween.get island
      island.alpha = 0
      tween.to alpha:1, DURATION_FADE_ISLAND
      tween.wait TIME_BEGIN_ZOOM_ISLAND_TO_FARM
      tween.to {scaleX: 3, scaleY: 3, x: -185.6, y: -544, alpha: 0.4}, DURATION_ZOOM_ISLAND_TO_FARM, cj.Ease.quadIn
      tween.to alpha: 0, DURATION_SWAP_ISLAND_TO_FARM
      tween.to _off: true
      return tween

    farmArrival = (farm) ->
      farm._off = true
      farm.alpha = 0
      tween = cj.Tween.get farm
      tween.wait TIME_BEGIN_SWAP_ISLAND_TO_FARM
      tween.to _off: false
      tween.to alpha:1, DURATION_SWAP_ISLAND_TO_FARM
      tween.to alpha:0.5, DURATION_PEPI_ENTRANCE
      return tween

    pepiEntrance = (pepi, startPoint, endPoint) ->
      pepi._off = false
      tween = cj.Tween.get pepi
      tween.to {x: startPoint.x, y: startPoint.y}
      tween.wait TIME_BEGIN_PEPI_ENTRANCE
      tween.to _off: false
      tween.to {x: endPoint.x, y: endPoint.y}, DURATION_PEPI_ENTRANCE, cj.Ease.quadOut
      return tween

    showBubble = (text) ->
      bubble = new sp.Bubble("synched", 0, text, "#33FF66")
      bubble.setTransform(684, 167.5, 1, 1, 0, 0, 0, 216, 92.5)
      bubble._off = true
      tween = cj.Tween.get bubble
      tween.wait(TIME_END_PEPI_ENTRANCE)
      tween.to {startPosition:0,_off:false}
      return tween

    playBubble = (target, soundId) ->
      tween = cj.Tween.get(target)
      tween.wait TIME_BEGIN_PEPI_WELCOME
      tween.call () -> cj.Sound.play(soundId, cj.Sound.INTERRUPT_EARLY, 0, 0, undefined)
      return tween

    # Define the actors in the movie
    island = new sp.Island()
    farm = new sp.Farm()
    pepi = new sp.Pepi()

    # Objects which appear first are drawn on top.
    # Can we make it more linear and change the z-order?
    @timeline.addTween pepiEntrance pepi, new cj.Point(-450, -100), new cj.Point(-110, 110)

    @timeline.addTween showBubble "Hello Kids!\nWelcome to my island!"
    @timeline.addTween playBubble @, 'sound-pepi'

    @timeline.addTween farmArrival farm

    @timeline.addTween islandArrival island

    return

  root[targetNS][localName].prototype = new cj.MovieClip()
  root[targetNS][localName].prototype.nominalBounds = new cj.Rectangle(0, 0, 1024, 768)
  return

)(this, "SavvyParrot", "ExampleMovieClip", SavvyParrot, createjs)
