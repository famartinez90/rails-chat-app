// Action Cable provides the framework to deal with WebSockets in Rails.
// You can generate new channels where WebSocket features live using the `rails generate channel` command.
//
//= require action_cable
//= require_self
//= require_tree ./channels/chat/

(function () {
	this.App || (this.App = {});

	App.cable = ActionCable.createConsumer();

	var post = function(path, file){
		var XHR = new XMLHttpRequest();
		XHR.open('POST', path);
		XHR.send(file);
	}

	var fill_with_chat_additional_info = function(fd){
		var type = document.getElementById('type');
		var id_group = document.getElementById('id_group');
		var message_to = document.getElementById('to');

		fd.append('type', type.innerText);

		if (id_group) {
			fd.append('id_group', id_group.innerText);
		}

		if (message_to) {
			fd.append('message_to', message_to.innerText);
		}
	}

	document.addEventListener('DOMContentLoaded', function () {
		var record = document.querySelector('.record');
		var stop = document.querySelector('.stop');
		var upload_picture = document.querySelector('.upload_picture');
		var upload_audio = document.querySelector('.upload_audio');

		upload_picture.onclick = function () {
			var file = document.getElementById('picture');
			if (file) {
				var fd = new FormData();
				fd.append('picture', file.files[0]);
				fill_with_chat_additional_info(fd);
				post('/upload/picture', fd);
				file.value = '';
			}
		}

		if (navigator.mediaDevices.getUserMedia) {
			var constraints = { audio: true };
			var chunks = [];

			var onSuccess = function (stream) {
				var mediaRecorder = new MediaRecorder(stream);

				record.onclick = function () {
					mediaRecorder.start();
				}

				stop.onclick = function () {
					mediaRecorder.stop();
				}

				mediaRecorder.onstop = function (e) {
					var blob = new Blob(chunks, { 'type': 'audio/ogg; codecs=opus' });
					chunks = [];
					var fd = new FormData();
					fd.append('audio_name', 'record.ogg');
					fd.append('audio', blob);
					fill_with_chat_additional_info(fd);
					post('/upload/audio', fd);
				}

				mediaRecorder.ondataavailable = function (e) {
					chunks.push(e.data);
				}

				upload_audio.onclick = function (e) {
					var audio = document.getElementById('file');
					if (audio){
						var fd = new FormData();
						fd.append('audio_name', 'record.ogg');
						fd.append('audio', audio.files[0]);
						fill_with_chat_additional_info(fd);
						post('/upload/audio', fd);
					}
				}
			}

			var onError = function (err) {
				console.log('The following error occured: ' + err);
			}

			navigator.mediaDevices.getUserMedia(constraints).then(onSuccess, onError);

		} else {
			console.log('getUserMedia not supported on your browser!');
		}
	}, false);

}).call(this);
