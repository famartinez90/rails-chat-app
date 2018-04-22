#= require action_cable
#= require_self

@App = @App || {}
App.cable = App.cable || ActionCable.createConsumer()
App.active_users = App.cable.subscriptions.create(
  "HomeChannel",
  connected: ->
    user = $('#user').text()
    @perform 'speak', { connected_user: user }

  disconnected: ->

  received: (data) ->
    current_user = $('#user').text()
    if data.connected_user && data.connected_user != current_user
      $('#active_users').append("<div>#{data.connected_user}</div>")
    # TODO: else if data.disconnected_user

)
