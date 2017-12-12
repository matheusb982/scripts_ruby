require 'gtk3'
require "pp"
require "serialport"

class RubyApp < Gtk::Window

    def initialize
        super

        set_title "Gravação Serial Port"
        signal_connect "destroy" do
            Gtk.main_quit
        end

        init_ui

        set_default_size 300, 150
        set_window_position(:center)

        show_all
    end

    def init_ui
        # deprecated -> button = Gtk::Button.new "About"
        button = Gtk::Button.new(:label => "Iniciar")
        button.set_size_request 80, 30

        button.signal_connect "clicked" do
            on_clicked
            button.destroy
        end

        fix = Gtk::Fixed.new
        fix.put button, 20, 20
        add fix

    end

    def on_clicked
      print_stor
    end

    def print_stor
      ports=Dir.glob("/dev/ttyUSB*")
      if ports.size != 1
      	printf("Cabo não conectado /dev/ttyUSB* serial\n")
      	exit(1)
      end
      print 'passou'
      port = ports[0]
      baud_rate = 4800
  		data_bits = 8
  		stop_bits = 1
  		parity = SerialPort::NONE

      sp = SerialPort.new(port, baud_rate, data_bits, stop_bits, parity)

      d=0x16

      sleep(0.01)

      sp.flush()


      sp.putc(d)
  		sp.flush()
  		printf("# W : 0x%02x\n", d.ord)


    	sp.flush()

    	c=sp.read()
      sleep(0.01)

    end

    def read
  		sp.flush()
  		printf("#Lendo ...\n")
  		c=nil
  		while c==nil
  			c=sp.read(1)
  			break if c != nil
  		end
  		printf("# R : 0x%02x\n", c.ord)
  		return c
      
  	end

end
# Gtk.init
    window = RubyApp.new
Gtk.main
