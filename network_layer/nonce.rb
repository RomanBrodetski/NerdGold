class Nonce
	def self.get
		r = File.read("network_layer/nonce.txt").to_i
		File.open("network_layer/nonce.txt", 'w') {|f| f.write(r + 1) }
		r
	end
end