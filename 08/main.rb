require './program.rb'
require './handheld.rb'

cpu = HandheldCPU.new()
prog = ReadProgram("input")
puts "%d instructions loaded" % prog.size()

cpu.load(prog)
cpu.run()

puts "This program terminated correctly: %s" % cpu.wasLastRunTerminated()
