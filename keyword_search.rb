require 'pdf-reader'
require 'open-uri'

number_of_words = 0
text_page = []

puts "Qual palavra deseja buscar?"  
STDOUT.flush  
text = gets.chomp  

puts '----INICIANDO LEITURA-----'
reader = PDF::Reader.new("teste.pdf")
#puts reader.pdf_version
#puts reader.info
#puts reader.metadata
#puts reader.page_count
reader.pages.each do |page|
	page.text.downcase.split(/[^[[:word:]]]+/).map{ |p| 
		puts p
		text_page << p 
	}
end
puts '----LEITURA FINALIZADA----'
puts "Detectado #{text_page.count(text)} ocorrências da sua palavra-chave"
