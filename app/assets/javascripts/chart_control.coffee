$ ->
  $('.keys-button').click ->
    $('.disabled').removeClass('disabled')
    $('.active-chart').removeClass('active-chart')
    $(this).addClass('disabled')
    $('.keys').addClass('active-chart')

  $('.clicks-button').click ->
    $('.disabled').removeClass('disabled')
    $('.active-chart').removeClass('active-chart')
    $(this).addClass('disabled')
    $('.clicks').addClass('active-chart')

  $('.download-button').click ->
    $('.disabled').removeClass('disabled')
    $('.active-chart').removeClass('active-chart')
    $(this).addClass('disabled')
    $('.download').addClass('active-chart')

  $('.upload-button').click ->
    $('.disabled').removeClass('disabled')
    $('.active-chart').removeClass('active-chart')
    $(this).addClass('disabled')
    $('.upload').addClass('active-chart')

  $('.uptime-button').click ->
    $('.disabled').removeClass('disabled')
    $('.active-chart').removeClass('active-chart')
    $(this).addClass('disabled')
    $('.uptime').addClass('active-chart')
