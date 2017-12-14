require 'gtk3'
require "pp"
require "serialport"
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
text.set_text ""
box.pack_start text

button = Gtk::Button.new(:label => "Inserir")
button.signal_connect "clicked" do
    puts "Hello "+text.text+"!"
    @baud_rate = text.text
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
  #window2.set_title "Controlador Serial Port"
  window2.signal_connect "destroy" do
      Gtk.main_quit
  end

  box = VBox.new 10

  button = Gtk::Button.new(:label => "Inserir")

  button.signal_connect "clicked" do
      #puts baud_rate
      check_connection
  end

  box.pack_start button

  window2.add box
  window2.show_all
end

def check_connection
  retur = true
  ports=Dir.glob("/dev/ttyUSB*")
  if ports.size != 1
    printf("Cabo não conectado /dev/ttyUSB* serial\n")
    retur = false
    #on_erro
    #exit(1)
    not_connect
  end

  if retur == true
    read_write_sp(ports)
  end
end

def read_write_sp(ports)
  port = ports[0]
  #baud_rate = 4800
  data_bits = 8
  stop_bits = 1
  parity = SerialPort::NONE

  sp = SerialPort.new(port, @baud_rate.to_i, data_bits, stop_bits, parity)

  d=0x16

  sleep(0.01)

  sp.flush()

  sp.putc(d)

  sp.flush()

  printf("# W : 0x%02x\n", d.ord)

  sp.flush()

  c=sp.read(1)

  printf("# R : 0x%02x\n", c.ord)

  sp.flush()

  sleep(0.01)
  processing_completed
end

def not_connect
  puts 'dialog'
  md = Gtk::MessageDialog.new(:parent => nil, :flags => :destroy_with_parent,
                            :type => :error, :buttons_type => :close,
                            :message => "Cabo não conectado")
  md.run
  md.destroy
end

def processing_completed
  puts 'dialog'
  md = Gtk::MessageDialog.new(:parent => nil, :flags => :destroy_with_parent,
                            :type => :info, :buttons_type => :close,
                            :message => "Gravação Finalizada")
  md.run
  md.destroy
end

Gtk.main
