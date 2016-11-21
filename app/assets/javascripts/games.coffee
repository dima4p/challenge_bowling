sleep_and_test = ->
  if $('body.games.show').length > 0
    setTimeout check_job_state, 2000

check_job_state = ->
  if $('body.games.show').length > 0
    Turbolinks.visit '/games/' + document.URL.split('/').pop()

document.addEventListener "turbolinks:load", sleep_and_test
