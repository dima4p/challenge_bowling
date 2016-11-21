do_update = ->
  $('body.games.show').length > 0 and $('body.games.show dd.on').length > 0

sleep_and_test = ->
  if do_update()
    setTimeout check_job_state, 2000

check_job_state = ->
  if do_update()
    Turbolinks.visit '/games/' + document.URL.split('/').pop()

document.addEventListener "turbolinks:load", sleep_and_test
