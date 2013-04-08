module History
	Main = "btc"
	Out = "rur"
	def current_rate pair = "ltc_btc"
		pair = "btc_usd" if pair == "usd_btc"
		return 1 if pair == "btc_btc"
		c = request("depth", pair)["asks"][0][0]
		pair == "btc_usd" ? 1.0 / c : c
	end

	def savings
		main_out_rate = current_rate "#{Main}_#{Out}"
		signed_request("getInfo")["funds"].inject(0) do |sum, h|
			if %w[ltc btc usd].include?(h[0])
				rate = current_rate("#{h[0]}_#{Main}")
				puts "savings in #{h[0]}: #{res = h[1]} #{h[0]} #{rate} #{Main} #{res = res * rate * main_out_rate} #{Out}"
				sum + res
			else
				sum
			end
		end
	end
end
