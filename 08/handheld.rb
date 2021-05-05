class HandheldCPU

  def initialize()
    reset()
  end

  def reset()
    @accumulator = 0
    @terminated = false
    @position = 0
    @jumplist = Array.new()
  end

  def load(prog)
    @program = prog
    initialize()
  end

  def run()
    reset()
    while not @jumplist.include? @position
      cycle()
    end
    puts "Accumulator value: %d" % [@accumulator]
  end

  def wasLastRunTerminated()
    return @terminated
  end

  def cycle()
    fetch()
    execute()
  end

  def fetch()
    line = @program.at(@position)
    if line == nil
      @terminated = true
    else
      line = line.split(" ")
      @instruction = line[0]
      @parameter = line[1]
    end

    @jumplist.append(@position)
  end

  def execute()
    if @terminated
      return
    end

    case @instruction
    when 'nop'
      @position += 1
    when 'jmp'
      @position += @parameter.to_i()
    when 'acc'
      @accumulator += @parameter.to_i()
      @position += 1
    when nil
      @terminated = true
    else
      raise "Unknown instruction '%s'" % @instruction
    end
  end

end
