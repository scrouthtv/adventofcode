class HandheldCPU

  def initialize()
    @accumulator = 0
  end

  def load(prog)
    @program = prog
    @position = 0
  end

  def run()
    while not @program.wasAt(@position)
      cycle()
    end
    puts "Accumulator value: %d" % [@accumulator]
  end

  def cycle()
    fetch()
    execute()
  end

  def fetch()
    line = @program.at(@position).split(" ")
    if line == nil
      @instruction = "nop"
      @parameter = nil
    else
      @instruction = line[0]
      @parameter = line[1]
    end
  end

  def execute()
    case @instruction
    when 'nop'
      @position += 1
    when 'jmp'
      @position += @parameter.to_i()
    when 'acc'
      @accumulator += @parameter.to_i()
      @position += 1
    else
      raise "Unknown instruction " + @instruction
    end
  end

end
