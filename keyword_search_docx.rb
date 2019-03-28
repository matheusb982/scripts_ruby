#Script developed to search for a specific keyword in a DOCX file

require 'docx'

number_of_words = 0
text_page = []

puts "Qual palavra deseja buscar?"  
STDOUT.flush  
text = gets.chomp 

puts '----INICIANDO LEITURA-----'
doc = Docx::Document.open('teste.docx')

doc.paragraphs.each do |p|
	puts p
	p.text.downcase.split(/[^[[:word:]]]+/).map{ |pc|
		text_page << pc
	}	
end
puts '----LEITURA FINALIZADA----'
puts "Detectado #{text_page.count(text)} ocorrências da sua palavra-chave"
