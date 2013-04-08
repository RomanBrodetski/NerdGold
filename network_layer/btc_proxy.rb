require 'openssl'
# require 'opennet'
require 'json'

require_relative 'ssl_monkeypatch'
require_relative 'nonce'

$BTC_api_key = "H8F6JYPA-C5DTTNYZ-6B1Y80DS-NMKODAGC-WPMLBEAK"
$BTC_api_secret = "dc44d11c4410925188305b7b8c3aed73fea3c052f76cb70ae4feab494da20c6d"

module BTC

	def request method, pair = "ltc_btc"
		JSON.parse(open("https://btc-e.com/api/2/#{pair}/#{method}").read)
	end

	def signed_request method, params = {}
		params = {
			:method => method,
        	:nonce => Nonce.get}.merge params
		headers = {
			"Content-type" => "application/x-www-form-urlencoded",
            "Key" => $BTC_api_key,
            "Sign" => sign(params)}
		uri = URI.parse("https://btc-e.com/tapi")
		request = Net::HTTP::Post.new uri.request_uri, headers
		request.set_form_data params

		response = Net::HTTP.new(uri.hostname, uri.port)
		response.use_ssl = true
		response = response.request request

		json = JSON.parse(response.body)
		raise json["error"] unless json["success"] == 1
		json["return"]
 	end

	def sign params
		digest  = OpenSSL::Digest::SHA512.new

		OpenSSL::HMAC.hexdigest(digest, $BTC_api_secret, URI.encode_www_form(params))
	end
end