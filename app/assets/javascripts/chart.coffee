$ ->
  $('#users_form').submit ->
    NProgress.start()
    $('.query-container').addClass('query-container-top')

    chartIds = ['#keys-chart', '#clicks-chart', '#download-chart', '#upload-chart', '#uptime-chart']
    resultKeys = [ 'Keys', 'Clicks', 'DownloadMB', 'UploadMB', 'UptimeSeconds' ]
    labelLeft = [ '.keys-left', '.clicks-left', '.download-left', '.upload-left', '.uptime-left' ]
    labelRight = [ '.keys-right', '.clicks-right', '.download-right', '.upload-right', '.uptime-right' ]

    user1 = $('#user1').val()
    user2 = $('#user2').val()
    api_route = '/poll?user1='+user1+'&user2='+user2

    $.get api_route, (data) ->
      NProgress.done()

      results =
        user1 : ""
        user2 : ""

      results.user1 = jQuery.parseJSON(data.user1)
      results.user2 = jQuery.parseJSON(data.user2)

      $('.canvases-container').fadeIn()

      for attribute, index in chartIds
        chart = $(attribute).get(0).getContext("2d")
        new Chart(chart).Doughnut(parsedAttribute(results, resultKeys[index]))
        setAndAlignLabels(results, resultKeys[index], labelLeft[index], labelRight[index])

      $('.canvas-label').fadeIn()

      show_labels = () ->
        $('.chart-label').fadeIn()
        $('.arc_down').arctext({radius:120, dir:1})
        $('.arc_up').arctext({radius:120, dir:-1})

      setTimeout show_labels, 2000

  parsedAttribute = (results, resultKey) ->
      [ { value: parseInt(results.user2[resultKey]), color:"#79bd9a" },\
        { value: parseInt(results.user1[resultKey]), color : "#3b8686" }]

  setAndAlignLabels = (results, resultKey, labelLeft, labelRight) ->
    user2_uptime = parseInt(results.user2[resultKey])
    user1_uptime = parseInt(results.user1[resultKey])
    user2_rotate = parseInt(user2_uptime/(user2_uptime+user1_uptime)*360/2)
    user1_rotate = parseInt(user1_uptime/(user2_uptime+user1_uptime)*360/2)+(user2_rotate*2)

    $(labelRight).html(commaify(user2_uptime))
    $(labelLeft).html(commaify(user1_uptime))
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
