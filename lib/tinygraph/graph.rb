# Frozen_string_literal: true

module Tinygraph
  # A graph
  class Graph
    attr_accessor :nodes

    def initialize
      @nodes = []
      @index = Index.new
    end

    def add_node(node)
      @nodes << node
    end

    def add_edge(from, to)
      from_node = @nodes.find { |node| node.id == from.id }
      to_node = @nodes.find { |node| node.id == to.id }

      from_node.edges_out << to_node
      to_node.edges_in << from_node
    end

    def breadth_first_traversal(node, distance: -1)
      queue = [node]
      visited = []
      next_level = []

      # We slightly modify the algorithm so we can find a distance if we want
      distance += 1 unless distance.negative?

      until queue.empty?
        # Get the first node in the queue
        current_node = queue.shift
        visited << current_node

        # Add the nodes that this links to the next level
        next_level += current_node.edges_out.reject { |n| visited.include?(n) }

        # If we have nodes in the queue, keep processing them
        next unless queue.count.zero?

        # If we *are* caring about distance, then reduce the distance by 1 since we're through a level
        # If we're not caring this will just keep decrementing, doesn't matter
        distance -= 1

        # If we care about distance and we're at 0, then we're done
        break if distance.zero?

        # Otherwise... if we don't have any nodes in the queue, then we're done with this level,
        # add the next ones to the queue and clear the next level
        queue += next_level
        next_level = []
      end

      visited
    end

    # Depth first traversal, obviously. The distance is the number of hops from `node` to traverse
    # if the distance is less than 0 then it will traverse the entire graph
    def depth_first_traversal(node, distance: -1)
      visited = []

      visited << node
      return visited if distance.zero?

      # Recursive is probably the easiest way to do this
      node.edges_out.each do |n|
        visited += depth_first_traversal(n, distance: distance - 1)
      end

      visited
    end

    def to_s
      @nodes.map do |node|
        "#{node.name}:#{@id} -> #{node.edges_out.map(&:name)}"
      end.join("\n")
    end
  end
end
