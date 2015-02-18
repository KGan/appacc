class RPNCalculator

  attr_accessor :value

  def initialize
    @cstack = []
    @value = nil
  end

  def push(num)
    @cstack.push(@value) if @value
    @value = num.to_f
  end

  @@operations = {:plus => :+, :minus => :-, :times => :*, :divide => :/}

  @@operations.each do |operation, symbol|
    define_method operation do
      raise "calculator is empty" if @cstack.empty?
      @value = @cstack.pop.send(symbol, @value)
    end
  end

  def tokens(str)
    str.split(" ").map {|tokest|
      if /[0-9]+/.match(tokest) then
        tokest.to_f
      else
        tokest.to_sym
      end
    }
  end

  def evaluate(str)
    self.tokens(str).each do |token|
      if token.is_a? Numeric then
        self.push(token)
      else
        self.send(@@operations.invert[token])
      end
    end
    self.value
  end

  def get_char
    begin
      system("stty raw -echo")
      str = STDIN.getc
    ensure
      system("stty -raw echo")
    end
    print str.chr
    str.chr
  end

  def realtime
    loop do
      fullstring = ""
      loop do
        c = get_char
        fullstring << c
        break if c =~ /[^0-9]/
      end
      fullstring.chomp!
      break if fullstring == "q"
      if fullstring[-1] =~ /[^0-9]/
        puts
        fullstring = fullstring[0..-2] << " " << fullstring[-1]
      end
      puts evaluate(fullstring)
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  rpn = RPNCalculator.new
  if File.exists?(ARGV[0])
    puts rpn.evaluate(File.readlines(ARGV[0]).join(" "))
  else
    rpn.realtime
  end
end
