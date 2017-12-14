require 'gtk3'
include Gtk

Gtk.init

window = Window.new
window.set_default_size 400, 250
window.set_window_position(:center)

window.show
window.set_title "Controlador Serial Port"
window.signal_connect "destroy" do
    Gtk.main_quit
end

box = VBox.new 10

text = Entry.new
text.set_text "Digite o baud rate"
box.pack_start text

button = Gtk::Button.new(:label => "Inserir")

button.signal_connect "clicked" do
    puts "Hello "+text.text+"!"
end

box.pack_start button

window.add box
window.show_all

Gtk.main
