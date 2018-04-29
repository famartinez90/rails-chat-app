$(document).on 'ready', () ->
	App.active_users = App.cable.subscriptions.create(
		"HomeChannel",
		{
			connected: ->
				user = $('#user').text()
				@perform 'speak', { connected_user: user }

			disconnected: ->

			received: (data) ->
				current_user = $('#user').text()

				if data.disconnected_user
					console.log('se desconecto el usuario ' + data.disconnected_user)

				if data.connected_user
					if data.connected_user != current_user
						$('#active_users').append(
							"<div id=#{data.connected_user}>\
								<p>#{data.connected_user}</p>\
                <form action=/private/join class=button_to data-remote=true method=post>\
                  <div>
                    <input type=submit value=chat>\
                    <input type=hidden name=to value=#{data.connected_user}>\
                </div>\
                </form>\
							</div>")
				else if data.disconnected_user
					$('#active_users').children('div').filter( ->
						$(this).text() == data.disconnected_user
					).remove()
		}
	)
