require './program.rb'
require './handheld.rb'

def advance(prog, i)
  loop do
    i += 1

    break if prog.at(i) == nil
    break if prog.at(i).start_with?("nop") or
      prog.at(i).start_with?("jmp")
  end
  return i
end

cpu = HandheldCPU.new()
prog = ReadProgram("input")
puts "%d instructions loaded" % prog.size()

cpu.load(prog)

replacePosition = -1

oldLine = ""

loop do
  replacePosition = advance(prog, replacePosition)
  # We started at -1 so it's ok to first advance

  oldLine = prog.at(replacePosition)

  puts "\nReplacing %d: %s" % [replacePosition, oldLine]

  if oldLine == nil
    puts "Couldn't find any nop or jmp to replace."
    break
  elsif oldLine.start_with?("nop")
    prog.setLine(replacePosition, oldLine.sub("nop", "jmp"))
  elsif oldLine.start_with?("jmp")
    prog.setLine(replacePosition, oldLine.sub("jmp", "nop"))
  end

  # Try the program we just created:
  cpu.run()
  break if cpu.wasLastRunTerminated
  puts "Did not terminate"

  # Return to the old program if it didn't work:
  prog.setLine(replacePosition, oldLine)
end

puts "Fixed line %d (was %s) for you" % [ replacePosition, oldLine.strip() ]
