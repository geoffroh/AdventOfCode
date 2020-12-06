# https://adventofcode.com/2020/day/5

class AocDay5
  attr_reader :input

  def initialize
    @input = File.read("2020/input/5").split("\n")
  end

  def max_seat
    all_seat_numbers.max
  end

  def open_seat
    sorted = all_seat_numbers.sort
    all_possible_seats = (sorted.first..sorted.last).to_a
    (all_possible_seats - sorted).first
  end

  private

  def all_seat_numbers
    input.map {|i| seat_to_int(i) }
  end

  def seat_to_int(s)
    s.gsub(/[BR]/, "1").gsub(/[FL]/, "0").to_i(2)
  end
end

part_a = AocDay5.new.max_seat
puts "part_a: #{part_a}"

part_b = AocDay5.new.open_seat
puts "part_b: #{part_b}"
