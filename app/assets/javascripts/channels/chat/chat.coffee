$(document).on 'ready', () ->
	params = {
			channel: $('#channel_type').text(),
			user: $('#from').text()
		}

	if $('#id_group') != undefined
		params['group'] = $('#id_group').text()

	if $('#to') != undefined
		params['to'] = $('#to').text()


	App.chat = App.cable.subscriptions.create(
		params
		{
			connected: ->
				console.log('conectado')
				console.log($('#id_group').text())

			received: (data) ->
				message = ''

				if data.from
					message += "<div align='left'>
								<p style='color:#2196F3'>
									#{data.from}
								</p>"
				else
					message += "<div align='center'>"

				message += "#{data.message}
							</div>"

				console.log(message)

				$('#messages').append(message)

			speak: (from, to, id_group, message) ->
				@perform 'speak', { from: from, to: to, message: message.trim(), id_group: id_group }
		}
	)

	$(document).on 'keypress', '[data-behavior~=speak]', (event) ->
		if event.keyCode is 13 # return/enter = send
			from = $('#from').text()
			id_group = $('#id_group').text()
			to = $('#to').text()
			App.chat.speak from, to, id_group,event.target.value
			event.target.value = ''
			event.preventDefault()