# https://adventofcode.com/2020/day/1

class AocDay1
  attr_reader :input

  def initialize
    @input = File.read("2020/input/1").split("\n").map(&:to_i)
  end

  # returns the first group that sums to the given number
  def group_sums_to_number(group_size, target_number)
    @input.permutation(group_size)
          .detect {|a, b| a + b == target_number }
  end
end

part_a = AocDay1.new.group_sums_to_number(2, 2020).reduce(&:*)
puts "part_a: #{part_a}"

part_b = AocDay1.new.group_sums_to_number(3, 2020).reduce(&:*)
puts "part_b: #{part_b}"
