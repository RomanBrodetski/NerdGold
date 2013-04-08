
require_relative 'network_layer/btc_proxy'


include BTC

puts signed_request("getInfo")
# puts signed_request("TransHistory")

buy_orders, sell_orders = request "depth"
puts buy_orders
puts request("trades")
# puts JSON.pretty_generate(history)
# puts history.map {|k, v| v["rate"]}.join(' -> ')


#1.2915
#1.3089
#1.2373
#https://btc-e.com/exchange/btc_rur