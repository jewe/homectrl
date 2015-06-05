

var Dashboard = {
	init: function(){
		$('.mode_buttons a').click(this.resetModeButtons);
	},

	setModeButton: function(mode){
		$('a#mode_' + mode).addClass('pure-button-primary');
		$('a#mode_' + mode).removeClass('pure-button-primary-disabled');
	},

	resetModeButtons: function(){
		$('.mode_buttons a').removeClass('pure-button-primary');
		$('.mode_buttons a').addClass('pure-button-primary-disabled');
	},

	requestStatus: function(url){
		console.log('query', url);
		$.getJSON(url).then(this.processStatus)
	},

	processStatus: function(json){
		console.log('mode', json.mode);
		Dashboard.setModeButton(json.mode);

		$('#temperature_display').text(json.temp + "°C");
		$('#humidity_display').text(json.humidity);

		json.valves.forEach(function(element, index, array){
			console.log(element, index, array);
			if (element == 1) $('#valve_' + index).addClass('active');
		});
	},

}