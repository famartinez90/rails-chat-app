$(document).on 'ready', () ->
	App.chat = App.cable.subscriptions.create(
		{
			channel: 'ChatChannel',
			group: $('#id_group').text()
		},
		{
			connected: ->
				console.log('conectado')
				console.log($('#id_group').text())

			received: (data) ->
				$('#messages').append(
					"<p style='color:#2196F3'>
						#{data.from}
					</p>
					<div align=left>
						#{data.message}
					</div>")

			speak: (from, id_group, message) ->
				@perform 'speak', { from: from, message: message, id_group: id_group }
		}
	)

	$(document).on 'keypress', '[data-behavior~=speak]', (event) ->
		if event.keyCode is 13 # return/enter = send
			from = $('#from').text()
			id_group = $('#id_group').text()
			App.chat.speak from, id_group, event.target.value
			event.target.value = ''
			event.preventDefault()