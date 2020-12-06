# https://adventofcode.com/2020/day/x

class AocDayX
  attr_reader :input

  def initialize
    @input = File.read("2020/input/x").split("\n").map(&:to_i)
  end

  def call(x)
  end
end

puts AocDayX.new.call(1)
