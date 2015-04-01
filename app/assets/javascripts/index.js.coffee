$ ->
  $("html").niceScroll()

  $('h1').addClass('flipInX animated')
  results =
    user1 : ""
    user2 : ""

  $('#users_form').submit ->
    NProgress.start()
    $('.query-container').animate({top:'10px'})
    keys_chart = $("#keys_chart").get(0).getContext("2d")
    clicks_chart = $("#clicks_chart").get(0).getContext("2d")
    download_chart = $("#download_chart").get(0).getContext("2d")
    upload_chart = $("#upload_chart").get(0).getContext("2d")
    uptime_chart = $("#uptime_chart").get(0).getContext("2d")

    user1 = $('#user1').val()
    user2 = $('#user2').val()
    api_route = '/poll?user1='+user1+'&user2='+user2

    $.get api_route, (data) ->
      results.user1 = jQuery.parseJSON(data.user1)
      results.user2 = jQuery.parseJSON(data.user2)

      NProgress.done()
      $('.canvas-container').fadeIn()
      new Chart(keys_chart).Doughnut(Keys(results))
      setAndAlignKeys(results)
      new Chart(clicks_chart).Doughnut(Clicks(results))
      setAndAlignClicks(results)
      new Chart(download_chart).Doughnut(DownloadMB(results))
      setAndAlignDownloadMB(results)
      new Chart(upload_chart).Doughnut(UploadMB(results))
      setAndAlignUploadMB(results)
      new Chart(uptime_chart).Doughnut(UptimeSeconds(results))
      setAndAlignUptimeSeconds(results)
      $('.canvas-label').fadeIn()

      show_labels = () ->
        $('.chart-label').fadeIn()
        $('.arc_down').arctext({radius:125, dir:1})
        $('.arc_up').arctext({radius:125, dir:-1})
      setTimeout show_labels, 1750
  
  Keys = (results) ->
      [ { value: parseInt(results.user2.Keys), color:"#79bd9a" },\
        { value: parseInt(results.user1.Keys), color : "#3b8686" }]

  Clicks = (results) ->
      [ { value: parseInt(results.user2.Clicks), color:"#79bd9a" },\
        { value: parseInt(results.user1.Clicks), color : "#3b8686" }]

  DownloadMB = (results) ->
      [ { value: parseInt(results.user2.DownloadMB), color:"#79bd9a" },\
        { value: parseInt(results.user1.DownloadMB), color : "#3b8686" }]

  UploadMB = (results) ->
      [ { value: parseInt(results.user2.UploadMB), color:"#79bd9a" },\
        { value: parseInt(results.user1.UploadMB), color : "#3b8686" }]

  UptimeSeconds = (results) ->
      [ { value: parseInt(results.user2.UptimeSeconds), color:"#79bd9a" },\
        { value: parseInt(results.user1.UptimeSeconds), color : "#3b8686" }]

  setAndAlignKeys = (results) ->
    user2_keys = parseInt(results.user2.Keys)
    user1_keys = parseInt(results.user1.Keys)
    user2_rotate = parseInt(user2_keys/(user2_keys+user1_keys)*360/2)
    user1_rotate = parseInt(user1_keys/(user2_keys+user1_keys)*360/2)+(user2_rotate*2)

    $('.keys_right').html(commaify(user2_keys))
    $('.keys_left').html(commaify(user1_keys))
    $('.keys_right').addClass('deg'+user2_rotate)
    $('.keys_left').addClass('deg'+user1_rotate)

    if user2_rotate > 90 and user2_rotate < 270
      $('.keys_right').addClass('arc_up')
    else
      $('.keys_right').addClass('arc_down')

    if user1_rotate > 90 and user1_rotate < 270
      $('.keys_left').addClass('arc_up')
    else
      $('.keys_left').addClass('arc_down')

  setAndAlignClicks = (results) ->
    user2_clicks = parseInt(results.user2.Clicks)
    user1_clicks = parseInt(results.user1.Clicks)
    user2_rotate = parseInt(user2_clicks/(user2_clicks+user1_clicks)*360/2)
    user1_rotate = parseInt(user1_clicks/(user2_clicks+user1_clicks)*360/2)+(user2_rotate*2)

    $('.clicks_right').html(commaify(user2_clicks))
    $('.clicks_left').html(commaify(user1_clicks))
    $('.clicks_right').addClass('deg'+user2_rotate)
    $('.clicks_left').addClass('deg'+user1_rotate)

    if user2_rotate > 90 and user2_rotate < 270
      $('.clicks_right').addClass('arc_up')
    else
      $('.clicks_right').addClass('arc_down')

    if user1_rotate > 90 and user1_rotate < 270
      $('.clicks_left').addClass('arc_up')
    else
      $('.clicks_left').addClass('arc_down')

  setAndAlignDownloadMB = (results) ->
    user2_download = parseInt(results.user2.DownloadMB)
    user1_download = parseInt(results.user1.DownloadMB)
    user2_rotate = parseInt(user2_download/(user2_download+user1_download)*360/2)
    user1_rotate = parseInt(user1_download/(user2_download+user1_download)*360/2)+(user2_rotate*2)

    $('.download_right').html(commaify(user2_download))
    $('.download_left').html(commaify(user1_download))
    $('.download_right').addClass('deg'+user2_rotate)
    $('.download_left').addClass('deg'+user1_rotate)

    if user2_rotate > 90 and user2_rotate < 270
      $('.download_right').addClass('arc_up')
    else
      $('.download_right').addClass('arc_down')

    if user1_rotate > 90 and user1_rotate < 270
      $('.download_left').addClass('arc_up')
    else
      $('.download_left').addClass('arc_down')

  setAndAlignUploadMB = (results) ->
    user2_upload = parseInt(results.user2.UploadMB)
    user1_upload = parseInt(results.user1.UploadMB)
    user2_rotate = parseInt(user2_upload/(user2_upload+user1_upload)*360/2)
    user1_rotate = parseInt(user1_upload/(user2_upload+user1_upload)*360/2)+(user2_rotate*2)

    $('.upload_right').html(commaify(user2_upload))
    $('.upload_left').html(commaify(user1_upload))
    $('.upload_right').addClass('deg'+user2_rotate)
    $('.upload_left').addClass('deg'+user1_rotate)

    if user2_rotate > 90 and user2_rotate < 270
      $('.upload_right').addClass('arc_up')
    else
      $('.upload_right').addClass('arc_down')

    if user1_rotate > 90 and user1_rotate < 270
      $('.upload_left').addClass('arc_up')
    else
      $('.upload_left').addClass('arc_down')

  setAndAlignUptimeSeconds = (results) ->
    user2_uptime = parseInt(results.user2.UptimeSeconds)
    user1_uptime = parseInt(results.user1.UptimeSeconds)
    user2_rotate = parseInt(user2_uptime/(user2_uptime+user1_uptime)*360/2)
    user1_rotate = parseInt(user1_uptime/(user2_uptime+user1_uptime)*360/2)+(user2_rotate*2)

    console.log(user2_uptime)
    console.log(user1_uptime)
    console.log(user2_rotate)
    console.log(user1_rotate)

    $('.uptime_right').html(commaify(user2_uptime))
    $('.uptime_left').html(commaify(user1_uptime))
    $('.uptime_right').addClass('deg'+user2_rotate)
    $('.uptime_left').addClass('deg'+user1_rotate)
    
    if user2_rotate > 90 and user2_rotate < 270
      $('.uptime_right').addClass('arc_up')
    else
      $('.uptime_right').addClass('arc_down')

    if user1_rotate > 90 and user1_rotate < 270
      $('.uptime_left').addClass('arc_up')
    else
      $('.uptime_left').addClass('arc_down')

  commaify = (number) ->
    number = number.toString().replace(/(\d+)(\d{3})/, '$1'+','+'$2') while /(\d+)(\d{3})/.test(number.toString())
    number




















