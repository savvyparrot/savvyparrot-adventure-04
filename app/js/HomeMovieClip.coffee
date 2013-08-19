((root, targetNS, localName, sp, cj) ->

  root[targetNS][localName] = (mode, startPosition, doLoop) ->
    @initialize(mode, startPosition, doLoop, {})

    DURATION_FADE_ISLAND = 24
    DURATION_SHOW_ISLAND = 12
    DURATION_PEPI_ENTRANCE = 32

    TIME_BEGIN_FADE_ISLAND = 0
    TIME_END_FADE_ISLAND = TIME_BEGIN_FADE_ISLAND + DURATION_FADE_ISLAND

    TIME_BEGIN_SHOW_ISLAND = TIME_END_FADE_ISLAND
    TIME_END_SHOW_ISLAND = TIME_BEGIN_SHOW_ISLAND + DURATION_SHOW_ISLAND

    TIME_BEGIN_PEPI_ENTRANCE = TIME_END_SHOW_ISLAND
    TIME_END_PEPI_ENTRANCE = TIME_BEGIN_PEPI_ENTRANCE + DURATION_PEPI_ENTRANCE

    TIME_BEGIN_PEPI_WELCOME = TIME_END_PEPI_ENTRANCE

    islandArrival = (island) ->
      tween = cj.Tween.get island
      island.alpha = 0
      tween.to alpha:1, DURATION_FADE_ISLAND
      return tween

    pepiEntrance = (pepi, startPoint, endPoint) ->
      pepi._off = false
      tween = cj.Tween.get pepi
      tween.to {x: startPoint.x, y: startPoint.y}
      tween.wait TIME_BEGIN_PEPI_ENTRANCE
      tween.to _off: false
      tween.to {x: endPoint.x, y: endPoint.y}, DURATION_PEPI_ENTRANCE, cj.Ease.quadOut
      return tween

    # Define the actors in the movie
    island = new sp.Island()
    pepi = new sp.Pepi()

    @timeline.addTween pepiEntrance pepi, new cj.Point(-450, -100), new cj.Point(-110, 110)

    @timeline.addTween islandArrival island

    return

  root[targetNS][localName].prototype = new cj.MovieClip()
  root[targetNS][localName].prototype.nominalBounds = new cj.Rectangle(0, 0, 1024, 768)
  return

)(this, "SavvyParrot", "HomeMovieClip", SavvyParrot, createjs)
