# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  $('[data-toggle="popover"]').popover(
    html: true
  )

  $('.alert-success').fadeTo(2000, 500).slideUp(500)
