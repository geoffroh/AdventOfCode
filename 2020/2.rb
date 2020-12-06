# https://adventofcode.com/2020/day/2

class AocDay2
  attr_reader :input

  def initialize
    @input = File.read("2020/input/2")
                 .split("\n")
  end

  def matching_rows_count_part_a
    @input.count do |row|
      min_and_max, letter, string = row.split(" ")
      min, max = min_and_max.split("-").map(&:to_i)
      letter_count_between(letter, min, max, string)
    end
  end

  def letter_count_between(letter, min, max, string)
    letter_count = string.count(letter)
    letter_count >= min && letter_count <= max
  end

  def matching_rows_count_part_b
    @input.count do |row|
      position_a, position_b, letter, string = row.split(/\W+/)

      one_of_two_positions_matching(letter, position_a.to_i, position_b.to_i, string)
    end
  end

  def one_of_two_positions_matching(letter, position_a, position_b, string)
    (string.chars[position_a - 1] == letter && string.chars[position_b - 1] != letter) ||
    (string.chars[position_a - 1] != letter && string.chars[position_b - 1] == letter)
  end
end

part_a = AocDay2.new.matching_rows_count_part_a
puts "part_a: #{part_a}"

part_b = AocDay2.new.matching_rows_count_part_b
puts "part_b: #{part_b}"
