require 'net/http'
require 'json'
require 'uri'

uri = URI('http://bases.etxpar.com.br:81/smc/v1/produto/categorias/')
http = Net::HTTP.new(uri.host, uri.port)
req = Net::HTTP::Get.new(uri.path, 'Authorization' => 'Bearer 01*Cu*ByCdAtW2yHpzHOeY_B2wg6Kn*MPlinZYvlWAn241J1LctqpeaOqbx_FCDW0s')
res = http.request(req)
puts "response #{res.body}"
