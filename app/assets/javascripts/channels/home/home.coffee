ready = ->
	App.active_users = App.cable.subscriptions.create(
		"HomeChannel",
		{
			connected: ->
				user = $('#user').text()
				@perform 'speak', { connected_user: user }
				@perform 'speak', { active_users_ping: true  }

			disconnected: ->

			received: (data) ->
				current_user = $('#user').text()

				if data.disconnected_user
					console.log('se desconecto el usuario ' + data.disconnected_user)

				if data.connected_user
					if data.connected_user != current_user && $("#active_users ##{data.connected_user}").length == 0
						$('#active_users').append(
							"<div id=#{data.connected_user}>\
                <form action=/private/join class=button_to data-remote=true method=post>\
                  <div>
                    <input class=\"list-group-item list-group-item-action\" type=submit value=#{data.connected_user}>\
                    <input type=hidden name=to value=#{data.connected_user}>\
                </div>\
                </form>\
							</div>")
				else if data.disconnected_user
          $("#active_users ##{data.disconnected_user}").remove()
        else if data.active_users_ping
          @perform 'speak', { connected_user: $('#user').text() }

		}
	)


$(document).ready(ready)
$(document).on('page:load', ready)
