class Program

  def initialize()
    @instructions = Array.new()
    @jumplist = Array.new()
  end

  def at(position)
    @jumplist << position
    return @instructions[position]
  end

  def wasAt(position)
    return @jumplist.include? position
  end

  def setLine(position, line)
    @instructions[position] = line
  end

  def size()
    return @instructions.length()
  end

end

def ReadProgram(filename)
  prog = Program.new()
  i = 0
  File.open(filename).each do |line|
    prog.setLine(i, line)
    i += 1
  end
  return prog
end
