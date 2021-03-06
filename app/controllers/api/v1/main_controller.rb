class API::V1::MainController < ActionController::Metal # ApplicationController
	require 'rubyserial'

	include ActionController::Rendering        # enables rendering
	#include ActionController::MimeResponds     # enables serving different content types like :xml or :json
	#include AbstractController::Callbacks      # callbacks for your authentication logic
	include ActionController::Renderers::All 

	append_view_path "#{Rails.root}/app/views" # you have to specify your views location as well

# http://databound.me/ optional:
# databound do
#     model :user
#     columns :name, :city
#   end



	def command
		# http://192.168.54.189:3001/api/v1/command/GT
		set_access_control_headers

		#sudo chmod 0777 /dev/serial/by-id/usb-FTDI_FT232R_USB_UART_A4007Uik-if00-port0

		# no usb: RubySerial::Exception: ENOENT
		# no access RubySerial::Exception: EACCES		

		serialport = Serial.new '/dev/serial/by-id/usb-FTDI_FT232R_USB_UART_A4007Uik-if00-port0'
		# empty buffer
		buffer = serialport.read 10000
		# send command
		cmd = "#{params[:cmd]}\n"
		serialport.write(cmd)
		n = Time.now
		#wait
		sleep 0.5
		#read
		out = ''
		out << serialport.read(10000)
		# wait and read later if nessesary
		if !out.include?('@') || out.blank? 
			sleep 0.8
			out << serialport.read(10000)
			if !out.include?('@') || out.blank?
				sleep 0.8
				out << serialport.read(10000)
			end
		end

		render json: {
			cmd: cmd,
			response: out,
			buffer: buffer,
			time: (Time.now - n)
		}
	end

	
private

	def set_access_control_headers
		headers['Access-Control-Allow-Origin'] = '*'
		headers['Access-Control-Request-Method'] = '*'
	end

end
