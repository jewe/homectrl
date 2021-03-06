class State < ActiveRecord::Base

	def self.process_messages
		Rails.logger.error "process_messages"
		serialport = Serial.new '/dev/serial/by-id/usb-FTDI_FT232R_USB_UART_A4007Uik-if00-port0'
		# empty buffer
		content = serialport.read 5000
		unless content.blank?

			content.split("\r\n").each do |line|
				timestamp,device_id,value = line.split(/S|V/,3)
				if device_id == 99 
					#VALVE_KITCHEN, LOW);
					# digitalWrite(VALVE_LIVINGROOM, LOW);
					# digitalWrite(VALVE_WINTERGARDEN1, LOW);
					# digitalWrite(VALVE_WINTERGARDEN2, LOW);
					# digitalWrite(VALVE_BATH, 
					device = Device.find(6)
					State.create({
						device_id: device.id,
						value: value
					})
				else 
					device = Device.find(device_id)
					State.create({
						device_id: device.id,
						value: value
					})
				end
			end
		end
	end
end
