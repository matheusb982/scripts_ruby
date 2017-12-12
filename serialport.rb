# link : http://playground.arduino.cc/interfacing/ruby

#simplest ruby program to read from arduino serial,
#using the SerialPort gem
#(http://rubygems.org/gems/serialport)

require "pp"
require "serialport"

class TTy

	def initialize

		# defaults params for arduino serial
		baud_rate = 4800
		data_bits = 8
		stop_bits = 1
		parity = SerialPort::NONE

		# serial port
		@sp=nil
		@port=nil
	end

	def open port
		@sp = SerialPort.new(port, @baud_rate, @data_bits, @stop_bits, @parity)
	end


	def shutdown reason

		return if @sp==nil
		return if reason==:int

		printf("\nshutting down serial (%s)\n", reason)

		# you may write something before closing tty
		@sp.write(0x00)
		@sp.flush()
		printf("done\n")
	end

	def read
		@sp.flush()
		printf("# R : reading ...\n")
		c=nil
		while c==nil
			puts 'ssss'
			c=@sp.read(1)
			puts "c >> #{c}"
			break if c != nil
		end
		printf("# R : 0x%02x\n", c.ord)
		return c
		# @sp.readByte()
	end

	def write c
		@sp.putc(c)
		@sp.flush()
		printf("# W : 0x%02x\n", c.ord)
	end

	def flush
		@sp.flush
	end
end


# serial port should be connected to /dev/ttyUSB*
ports=Dir.glob("/dev/ttyUSB0")
if ports.size != 1
	printf("did not found right /dev/ttyUSB0 serial")
	exit(1)
end

tty=TTy.new()
tty.open(ports[0])

at_exit     { tty.shutdown :exit }
trap("INT") { tty.shutdown :int  ; exit}

# reading thread
Thread.new do
	d=0x16
	pp d
	cont = 0
	while cont<5 do

		sleep(0.01)
		tty.write(d)
		tty.flush()

		# build a loop with a value (d) cycling from 0 to 255
		d=d+1
		d=d%255
		cont+=1
	end
	puts 'terminou'

	contd = 0
	while contd<5 do
		puts 'entrou'
		c=tty.read()
	  sleep(0.01)
		contd+=1
	end

end

#just read forever
contd = 0
while contd<5 do
	puts 'entrou'
	c=tty.read()
  sleep(0.01)
	contd+=1
end

sleep 500
tty.shutdown
