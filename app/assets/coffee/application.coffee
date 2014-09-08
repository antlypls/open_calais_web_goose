$ ->
  submit_url = ->
    $('#result').empty()
    params =
      url: $('#url').val()
      auth_token: $('#auth_token').val()

    $.post '/url', params, (data) ->
      $('#result').jsontree(data)

  $('#get_info').click ->
    submit_url()

  $('#url').keyup (e) ->
    submit_url() if e.keyCode == 13

  $('#url').click ->
    $(this).select()
