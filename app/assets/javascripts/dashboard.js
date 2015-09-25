

var Dashboard = {
	url: '',

	init: function(){
		$('.mode_buttons a').click(this.resetModeButtons);
		
		$('#load_intervals').click(this.loadIntervals);

		
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
		this.url = url;
		$.getJSON(url).then(this.processStatus);
	},

	processStatus: function(json){
		//console.log('mode', json.mode);
		Dashboard.setModeButton(json.mode);

		$('#temperature_display').text(json.temp + "°C");
		$('#humidity_display').text(json.humidity);

		$('#time_display').text("Uhrzeit " + json.time);
		var d = json.date.split('.');
		var date = new Date(d[2], d[1], d[0]);
		var options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
	
		$('#date_display').text( date.toLocaleDateString('de-DE', options) );


		json.valves.forEach(function(element, index, array){
			//console.log(element, index, array);
			if (element == 1) $('#valve_' + index).addClass('active');
		});
	},

	loadIntervals: function(){
		var url = $(this).data('url');
		var $container = $("#intervals_holder");
		$container.empty();
		$container.append("<table>");
		var table = $container.find('table');

		for (var i=0;i<6;i++){
			table.append("<tr id='interval_" + i + "'>");
			setTimeout(function(url){
				$.getJSON(url + "?id=" + this).then(Dashboard.processInterval);
			}.bind(i,url), 200*i);
		}
	},

	processInterval: function(json){
		console.log('processInterval', json);
		var id = json.interval.id;
		var $tr = $("#interval_" + id);
		$tr.empty();
		//$tr.append("<td>" + id + "</td>");
		$tr.append("<td>" + json.interval.mode_human + "</td>");
		$tr.append("<td>" + json.on_time + "</td>");
		$tr.append("<td>bis</td>");
		$tr.append("<td>" + json.off_time + "</td>");
		$tr.append("<td>" + json.repeat_human + "</td>");
	},


}