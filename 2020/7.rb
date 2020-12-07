# https://adventofcode.com/2020/day/7

class AocDay7
  attr_reader :input, :contained_by, :contents

  def initialize
    @input = File.read("2020/input/7").split("\n")
    # Formats the input in a {bag_type (contained_by) bag_type} hash so that we can see what a bag is contained in
    @contained_by = normalise_container_bags
    # Formats the input in a {bag_type (contains) {bag type: a, number: x}} hash,
    # so that we can see what/how many bags are contained in a given bag type
    @contents = normalise_bag_contents
  end

  # How many different bags can eventually contain a golden bag
  def part_a(bag_type)
    containers_for(bag_type).flatten.uniq.size
  end

  # How many bags must the given type contain
  def part_b(bag_type)
    contents_for(bag_type)
  end

  private

  # Recursively find the bags that can contain the given type
  def containers_for(bag_type)
    Array(contained_by[bag_type]).map do |container_bag_type|
      [container_bag_type] + containers_for(container_bag_type)
    end
  end

  # Recursively find the number of bags contained by the given type
  def contents_for(bag_type)
    Array(contents[bag_type]).sum do |number_and_type|
      number_and_type[:number] + number_and_type[:number] * contents_for(number_and_type[:type])
    end
  end

  # Turns the input to a hash of bag colour => bag colours they are contained in
  def normalise_container_bags
    input.reduce({}) do |acc, row|
      container, contents = row.split("s contain")
       contents.split(', ').map do |c|
         singular_content = c.gsub(/\d/, '').sub('bags', 'bag').sub('.', '').strip
         acc[singular_content]||=[]
         acc[singular_content] += [container]
       end
       acc
     end
  end


  def normalise_bag_contents
    input.reduce({}) do |acc, row|
      container, contents = row.split("s contain")
      acc[container] =
        contents.split(', ').reduce([]) do |b, c|
          break if c.strip == "no other bags."

          b += [
            {
              number: /\d/.match(c)[0].to_i,
              type: c.gsub(/\d/, '').sub('bags', 'bag').sub('.', '').strip
            }
          ]
        end
      acc
    end
  end
end

part_a = AocDay7.new.part_a("shiny gold bag")
puts "part_a: #{part_a}"

part_b = AocDay7.new.part_b("shiny gold bag")
puts "part_b: #{part_b}"
