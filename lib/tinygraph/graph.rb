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

    def breadth_first_traversal(node, distance: nil)
      queue = [node]
      visited = []

      if distance.nil?
        until queue.empty?
          # Get the first node in the queue
          current_node = queue.shift

          # Well, we've visited it!
          visited << current_node
          # Add the nodes that this links to to the queue
          queue += current_node.edges_out.reject { |n| visited.include?(n) }
        end
      else
        # Weirdly a lot more complex, though probably possible to merge
        depth = 0
        results = [node] + node.edges_out

        visited << node
        while depth < distance - 1
          next_loop = results.reject { |n| visited.include?(n) }
          next_loop.each do |n|
            visited << n
            results += n.edges_out
          end

          depth += 1 if depth < distance
        end

        return results
      end

      visited
    end

    # Same thing as breadth first, but with a stack instead of a queue
    # I'm sure it's easy enough to merge these two methods, but I'm not sure how/don't have time
    def depth_first_traversal(node, distance: nil)
      stack = [node]
      visited = []

      if distance.nil?
        until stack.empty?
          # Get the first node in the stack
          current_node = stack.shift

          # Well, we've visited it!
          visited << current_node
          # Add the nodes that this links to to the stack
          stack = current_node.edges_out.reject { |n| visited.include?(n) } + stack
        end
      else
        visited << node
        return visited if distance.zero?

        # Recursive is probably the easiest way to do this
        node.edges_out.each do |n|
          visited += depth_first_traversal(n, distance: distance - 1)
        end
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
