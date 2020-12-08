# https://adventofcode.com/2020/day/7

class AocDay7
  attr_reader :input, :bag_structure

  def initialize
    @input = File.read("2020/input/7").split("\n")
    @bag_data = parse_input
  end

  # How many different bags can eventually contain a golden bag
  def part_a(bag_type)
    containers_for(bag_type.sub(' bag', '')).flatten.uniq.size
  end

  # How many bags must the given type contain
  def part_b(bag_type)
    contents_for(bag_type.sub(' bag', ''))
  end

  private

  # Recursively find the bags that can contain the given type
  def containers_for(bag_type)
    @bag_data[bag_type]["contained_by"].map do |container_bag_type|
      [container_bag_type] + containers_for(container_bag_type)
    end
  end

  # Recursively find the number of bags contained by the given type
  def contents_for(bag_type)
    @bag_data[bag_type]["contains"].sum do |contents_type, contents_count|
      contents_count + contents_count * contents_for(contents_type)
    end
  end

  # Structures the input to a hash:
  # {"a" => {"contains" => {"b" => 2, "c" => 3}}, "contained_by" => ["d"}}
  def parse_input
    input.reduce({}) do |acc, row|
      key, data = row.split(" bags contain ")
      acc[key] ||= {"contains" => {}, "contained_by" => []}

      data.scan(/(\d) ([a-z]+ [a-z]+) bag/)
          .map do |dd|
            num, type = dd
            acc[key]["contains"].merge!(type => num.to_i)
            acc[type] ||= {"contains" => {}, "contained_by" => []}
            acc[type]["contained_by"] += [key]
          end
      acc
    end
  end
end

part_a = AocDay7.new.part_a("shiny gold bag")
puts "part_a: #{part_a}"

part_b = AocDay7.new.part_b("shiny gold bag")
puts "part_b: #{part_b}"
