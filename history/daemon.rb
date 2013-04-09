require_relative '../network_layer/btc_proxy'
require_relative 'history'
include BTC
include History


require 'win32/sound'
include Win32

def alarm
	2.times do
		4.times do
			Sound.beep 700, 200
		end
		sleep 1
	end
end
# alarm
# lo = gets.to_f
b_Range = (6550..7000)
l_Range = (0.02..0.03)
loop do
	begin
	puts "stats: ltc_btc #{a = current_rate "ltc_btc"}, btc_rub #{b = current_rate "btc_rur"}"
	puts savings
	5.times {puts}
	alarm unless b_Range.include? b && l_Range.include? a
	sleep 10
rescue Exception => e
	puts e
		# 30.times {Sound.beep(700, 15)}
end
end
# end
