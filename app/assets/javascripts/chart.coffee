$ ->
  $('#users_form').submit ->
    NProgress.start()
    moveQueryContainerToTop()

    statsTracked = [ 'keys', 'clicks', 'download', 'upload', 'uptime' ]

    user1 = $('#user1').val()
    user2 = $('#user2').val()
    apiRoute = '/poll?user1='+user1+'&user2='+user2

    $.get apiRoute, (results) ->
      NProgress.done()

      $('.canvases-container').fadeIn()

      for statistic in statsTracked
        chart = $(getChartId(statistic)).get(0).getContext("2d")
        new Chart(chart).Doughnut(parseAttribute(results, statistic))
        setAndAlignLabels(results, statistic, getLabelLeft(statistic), getLabelRight(statistic))

      $('.canvas-label').fadeIn()

      showLabels = () ->
        $('.chart-label').fadeIn()
        $('.arc_down').arctext({radius:120, dir:1})
        $('.arc_up').arctext({radius:120, dir:-1})

      setTimeout showLabels, 2000

  moveQueryContainerToTop = () ->
    $('.query-container').addClass('query-container-top')

  getChartId = (statistic) ->
    '#'+statistic+'-chart'

  getLabelLeft = (statistic) ->
    '.'+statistic+'-left'

  getLabelRight = (statistic) ->
    '.'+statistic+'-right'

  parseAttribute = (results, resultKey) ->
      [ { value: parseInt(results[1][resultKey]), color: "#79bd9a" },\
        { value: parseInt(results[0][resultKey]), color: "#3b8686" }]

  setAndAlignLabels = (results, resultKey, labelLeft, labelRight) ->
    user2_statistic = parseInt(results[1][resultKey])
    user1_statistic = parseInt(results[0][resultKey])
    user2_rotate = parseInt(user2_statistic/(user2_statistic+user1_statistic)*360/2)
    user1_rotate = parseInt(user1_statistic/(user2_statistic+user1_statistic)*360/2)+(user2_rotate*2)

    $(labelRight).html(commaify(user2_statistic))
    $(labelLeft).html(commaify(user1_statistic))
    $(labelRight).addClass('deg'+user2_rotate)
    $(labelLeft).addClass('deg'+user1_rotate)

    if user2_rotate > 90 and user2_rotate < 270
      $(labelRight).addClass('arc_up')
    else
      $(labelRight).addClass('arc_down')

    if user1_rotate > 90 and user1_rotate < 270
      $(labelLeft).addClass('arc_up')
    else
      $(labelLeft).addClass('arc_down')

  commaify = (number) ->
    number = number.toString().replace(/(\d+)(\d{3})/, '$1'+','+'$2')\
      while /(\d+)(\d{3})/.test(number.toString())
    number
