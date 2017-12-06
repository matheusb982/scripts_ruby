require 'net/http'
require 'json'
require 'uri'

uri = URI('http://bases.etxpar.com.br:81/smc/v1/cliente/')
http = Net::HTTP.new(uri.host, uri.port)
req = Net::HTTP::Post.new(uri.path, 'Authorization' => 'Bearer 01*Cu*ByCdAtW2yHpzHOeY_B2wg6Kn*MPlinZYvlWAn241J1LctqpeaOqbx_FCDW0s', 'Content-Type' => 'application/json')
req.body = {'id': '35323', 'nome': 'Francisco', 'email': 'teste@teste.com', 'cpfCnpj': '524.151.444-95', 'logradouro': 'Av Paulista', 'numero': '122', 'bairro': 'Bela Vista', 'cidade': 'Fortaleza', 'uf': 'CE', 'cep': '60533-170', 'pontoReferencia': 'Rua baixa', 'fone': '(11) 98888.0588'}.to_json
res = http.request(req)
puts "response #{res.body}"
