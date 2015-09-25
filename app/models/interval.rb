class Interval 
  	include ActiveModel::Validations
  	include ActiveModel::Conversion
  	extend ActiveModel::Naming

	attr_accessor :id, :on, :off, :repeat, :mode

	validates :id, :presence => true
	validates :on, :presence => true
	validates :off, :presence => true
	validates :repeat, :presence => true
	validates :mode, :presence => true

	# 1 | 870 | 1290 | 11 | 1\r\n
	def initialize str
		id, on, off, repeat, mode = str.split(' | ')
		send("id=", id.to_i)
		send("on=", on.to_i)
		send("off=", off.to_i)
		send("repeat=", repeat.to_i)
		send("mode=", mode.to_i)
	end

	def on_time
		h = (on/60.0).floor
		m = on%60
		"#{h}:#{m}"
	end

	def off_time
		h = (off/60.0).floor
		m = off%60
		"#{h}:#{m}"
	end

	def repeat_human
		case repeat
			when 0
  				"nie"
			when 1
  				"montags"
			when 2
  				"dienstags"
			when 3
  				"mittwochs"
			when 4
  				"donnerstags"
			when 5
  				"freitags"
			when 6
  				"samstags"
			when 7
  				"sonntags"
			when 10
  				"täglich"
			when 11
  				"werktags"
			when 12
  				"am Wochenende"

  			else
  				"fehlerhaft"
		end
	end

	def persisted? # no database
    		false
  	end
end
