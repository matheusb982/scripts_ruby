require "pp"
require "serialport"

class TTy

	def initialize

		puts 'Taxa de Transmissão?'
		$baud = STDIN.gets

		baud_rate = $baud#4800
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

		printf("\nDesligando serial (%s)\n", reason)

		@sp.write(0x00)
		@sp.flush()
		printf("done\n")
	end

	def read
		@sp.flush()
		printf("#Lendo ...\n")
		c=nil
		while c==nil
			c=@sp.read(1)
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

ports=Dir.glob("/dev/ttyUSB*")
if ports.size != 1
	printf("Cabo não conectado /dev/ttyUSB* serial\n")
	exit(1)
end

tty=TTy.new()
tty.open(ports[0])

at_exit     { tty.shutdown :exit }
trap("INT") { tty.shutdown :int  ; exit}

Thread.new do
	d=0x16
	pp d

	sleep(0.01)
	tty.write(d)
	tty.flush()

	c=tty.read()
  sleep(0.01)

end

sleep(0.10)
#tty.shutdown
