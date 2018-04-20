App.chat = App.cable.subscriptions.create "ChatChannel",

connected: -> # Called when the subscription is ready for use on the server
disconnected: -> # Called when the subscription has been terminated by the server

# Called when there's incoming data on the websocket for this channel
received: (data) ->
  if $("#from").text() == data.from
    $("#messages").append("<div align=left>#{data.message}</div>")
  else
    $("#messages").append("<div align=right>#{data.message}</div>")

speak: (from, to, message) ->
  @perform 'speak', from: from, to: to, message: message

$(document).on 'keypress', '[data-behavior~=speak]', (event) ->
  if event.keyCode is 13 # return/enter = send
    from = $("#from").text()
    to = $("#to").text()
    App.chat.speak from, to, event.target.value
    event.target.value = ''
    event.preventDefault()
