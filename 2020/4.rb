# https://adventofcode.com/2020/day/4

class AocDay4
  attr_reader :input
  VALID_KEYS = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]
  EYE_COLOURS = ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]

  # Converts each blank-line-separated entry into a hash
  def initialize
    @input = File.read("2020/input/4")
                 .split("\n\n")
                 .map do |p|
                   p.split(/\s+/).reduce({}) do |acc, kv|
                     key, value = kv.split(":")
                     acc.merge(key => value)
                   end
                 end
  end

  def valid_count_a
    input.count {|p| valid_part_a?(p)}
  end

  def valid_part_a?(p)
    p.key?("cid") ? p.values.size == 8 : p.values.size == 7
  end

  def valid_count_b
    input.count {|p| valid_part_b?(p)}
  end

  def valid_part_b?(p)
    p.map {|k, v| validate_field(k, v) }.compact == true &&
      p.key?("cid") ? p.values.size == 8 : p.values.size == 7
  end

  def validate_field(k, v)
    case k
    when "byr"
      v.length == 4 && v.to_i >= 1920 && v.to_i <= 2002
    when "iyr"
      v.length == 4 && v.to_i >= 2010 && v.to_i <= 2020
    when "eyr"
      v.length == 4 && v.to_i >= 2020 && v.to_i <= 2030
    when "hgt"
      if /cm/.match?(v)
        v.to_i >= 150 && v.to_i <= 193
      else
        v.to_i >= 59 && v.to_i <= 76
      end
    when "hcl"
      /#[0-9a-f]{6}/.match?(v)
    when "ecl"
      [EYE_COLOURS].include?(v)
    when "pid"
      /\d{9}/.match?(v)
    else
      false
    end
  end
end

part_a = AocDay4.new.valid_count_a
puts part_a

part_b = AocDay4.new.valid_count_b
puts part_b
