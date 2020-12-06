# https://adventofcode.com/2020/day/3

class AocDay3
  attr_reader :input

  def initialize
    @input = File.read("2020/input/3")
                 .split("\n")
                 .map {|row| row.chars }
  end

  def call(move_right, move_down)
    tree_count = 0
    x, y = [0, 0]
    while y < @input.size - 1
      x, y = [x + move_right, y + move_down]
      tree_count += 1 if tree_at?(x, y)
    end
    tree_count
  end

  def tree_at?(x, y)
    @input[y][x%@input.first.size] == "#"
  end
end

part_a = AocDay3.new.call(3, 1)
puts "part_a: #{part_a}"

part_b = [
  AocDay3.new.call(1, 1),
  AocDay3.new.call(3, 1),
  AocDay3.new.call(5, 1),
  AocDay3.new.call(7, 1),
  AocDay3.new.call(1, 2)
].reduce(&:*)
puts "part_b: #{part_b}"
