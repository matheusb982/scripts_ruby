require 'rubygems'
require 'rufus-scheduler'
require 'json'
require 'net/http'

scheduler = Rufus::Scheduler.new

# scheduler.interval '5s' do
  puts "Verificando Integração Categoria #{Time.now}"


  uri = URI('http://bases.etxpar.com.br:81/smc/v1/produto/categorias/')
  http = Net::HTTP.new(uri.host, uri.port)
  req = Net::HTTP::Get.new(uri.path, 'Authorization' => 'Bearer 01*Cu*ByCdAtW2yHpzHOeY_B2wg6Kn*MPlinZYvlWAn241J1LctqpeaOqbx_FCDW0s')
  res = http.request(req)
  resul = JSON.parse(res.body)

  puts resul

  valid = false

  # (0..resul["subcategorias"].size-1).map { |i|
  #   Category.all.each do |category|
  #     if category.api_id == resul["subcategorias"][i]["id"]
  #       valid = true
 #     end
  #   end
  #
  #   if valid == true
  #     category = Category.where(api_id: resul["subcategorias"][i]["id"]).last
  #     if category.name != resul["subcategorias"][i]["nome"]
  #       category.name = resul["subcategorias"][i]["nome"]
  #       category.save
  #       puts "Categoria atualizada #{category.id} - #{category.name}"
  #     end
  #   else
  #     category = Category.new
  #     category.api_id = resul["subcategorias"][i]["id"]
  #     category.name = resul["subcategorias"][i]["nome"]
  #     category.save
  #     puts "Categoria criada #{category.id} - #{category.name}"
  #   end
  # }


# end

scheduler.join
