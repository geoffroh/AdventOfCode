# https://adventofcode.com/2020/day/6

class AocDay6
  attr_reader :input

  def initialize
    @input = File.read("2020/input/6").split("\n\n").map {|group| group.split("\n") }
  end

  # Cumulative total of questions answered yes by at least one person in each group
  def part_a
    input.sum do |group|
      group.join().chars.uniq.size
    end
  end

  # Cumulative total of questions answered yes by all members in each group
  def part_b
    input.sum do |group|
      all_answers = group.join().chars
      answered_yes_at_least_once = group.join().chars.uniq

      answered_yes_at_least_once.select {|l| all_answers.count(l) == group.size }.size
    end
  end
end

part_a = AocDay6.new.part_a
puts "part_a: #{part_a}"

part_b = AocDay6.new.part_b
puts "part_b: #{part_b}"
