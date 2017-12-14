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
    new_window(text.text)
end

box.pack_start button

window.add box
window.show_all

def new_window(baud_rate)
  window2 = Window.new
  window2.set_default_size 400, 250
  window2.set_window_position(:center)

  window2.show
  window2.set_title "Controlador Serial Port"
  window2.signal_connect "destroy" do
      Gtk.main_quit
  end

  box = VBox.new 10

  button = Gtk::Button.new(:label => "Inserir")

  button.signal_connect "clicked" do
      puts baud_rate
  end

  box.pack_start button

  window2.add box
  window2.show_all
end

Gtk.main
