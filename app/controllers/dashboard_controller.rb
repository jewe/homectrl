class DashboardController < ApplicationController

	def index

	end

	def get_status
		answer = send_cmd("GS")
		mode = answer[:response].scan(/.*mode: ([0-9]).*/).first.first
		# time 15:26:33 5 6 2015 6
		time, d,m,y = answer[:response].scan(/.*time ([\d|:]{7,8}) ([\d]{1,2}) ([\d]{1,2}) ([\d]{4}) .*/).first
		# thermostats: 0\r\nhumidity: 51\r\ntemp: 22
		# THERMOSTAT_KITCHEN   THERMOSTAT_LIVINGROOM)  THERMOSTAT_WINTERGARDEN
		thermostats = answer[:response].scan(/.*thermostats: ([0-9]{1,3}).*/).first.first
		thermostats = thermostats.to_i.to_s(2).split("")
		# valves: 2
		valves = answer[:response].scan(/.*valves: ([0-9]{1,3}).*/).first.first
		valves = valves.to_i.to_s(2).split("")

		humidity = answer[:response].scan(/.*humidity: ([0-9]{1,3}).*/).first.first
		temp = answer[:response].scan(/.*temp: ([0-9]{1,3}).*/).first.first

		render json: {
			mode: mode,
			time: time,
			date: "#{d}.#{m}.#{y}",
			thermostats: thermostats, 
			humidity: humidity,
			temp: temp,
			valves: valves,
			debug: answer[:response],
		}
	end

	def set_mode		
		set_access_control_headers
		
		mode = params[:mode].to_i
		cmd = "SM#{mode}"
		@answer = send_cmd(cmd)
	end

	def get_interval 
		# http://192.168.178.123:3000/api/v1/command/GI1
		# 1 | 870 | 1290 | 11 | 1\r\n
		id = params[id].to_i
		#answer = send_cmd("GI#{id}")
		answer = '1 | 870 | 1290 | 11 | 1\r\n'
		interval = Interval.new(answer)
		render json: {
			interval: interval,
			on_time: interval.on_time,
			off_time: interval.off_time,
			repeat_human: interval.repeat_human,
		}
	end

	def get_intervals

	end

private 

	def set_access_control_headers
		headers['Access-Control-Allow-Origin'] = '*'
		headers['Access-Control-Request-Method'] = '*'
	end

	def send_cmd(cmd)
		# serialport = Serial.new '/dev/serial/by-id/usb-FTDI_FT232R_USB_UART_A4007Uik-if00-port0'
		# # empty buffer
		# buffer = serialport.read 10000
		# # send command
		# cmd = "#{cmd}\n"
		# serialport.write(cmd)
		# n = Time.now
		# #wait
		# sleep 0.5
		# #read
		# out = serialport.read 5000
		# # wait and read later if nessesary
		# if out.blank?
		# 	sleep 0.8
		# 	out = serialport.read 5000
		# 	if out.blank?
		# 		sleep 1
		# 		out = serialport.read 5000
		# 	end
		# end


		n = Time.now
		out = "mode: #{cmd[2]}\r\n"
		out = '\r\n// Status //\r\nmode: 3\r\n\r\ntime 5:26:33 5 6 2015 6\r\n\r\ncurrentIntId: 1\r\nvalves: 2\r\nthermostats: 2\r\nhumidity: 51\r\ntemp: 22\r\n\r\nid |on |off |repeat \r\n0 | 300 | 4'
		buffer = "" 

		return {
			cmd: cmd,
			response: out,
			buffer: buffer,
			time: (Time.now - n)
		}
	end

end
