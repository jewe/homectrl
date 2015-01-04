class State < ActiveRecord::Base

	def self.process_messages
		Rails.logger.error "process_messages"
		serialport = Serial.new '/dev/serial/by-id/usb-FTDI_FT232R_USB_UART_A4007Uik-if00-port0'
		# empty buffer
		content = serialport.read 5000
		unless content.blank?

			content.split("\r\n").each do |line|
				timestamp,device_id,value = line.split(/S|V/,3)
				device = Device.find(device_id)
				State.create({
					device_id: device.id,
					value: value
				})
			end
		end
	end
end
