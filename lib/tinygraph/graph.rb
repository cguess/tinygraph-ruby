# Frozen_string_literal: true

# TODO: Implement the following methods
# - [ ] Remove node
# - [ ] Remove edge
# - [x] Find node by name
# - [x] Find node by id
# - [ ] Find edge by from and to
# - [ ] Find edge by from
# - [ ] Find edge by to
# - [ ] Find edge by id

require "debug"

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
      @index.add_node(node)
    end

    def delete_node(node)
      node.edges.each { |edge| delete_edge(edge) }

      @index.nodes.delete(node)
      @nodes.delete(node)
    end

    def delete_edge(edge)
      edge.from.edges_out.delete(edge)
      edge.to.edges_in.delete(edge)

      edge.from = nil
      edge.to = nil
    end

    def add_edge(from, to)
      Edge.new(from, to)
    end

    def find_node(name: nil, id: nil)
      raise "You must provide either a name or an id" if name.nil? && id.nil?

      if name
        @index.find_by_name(name)
      else
        @index.find_by_id(id)
      end
    end

    def breadth_first_traversal(node, distance: -1)
      # First make sure the node is actually in the graph...
      raise "Node #{node.name} is not in the graph" unless @nodes.include?(node)

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
        nodes = current_node.edges_out.map(&:to)
        next_level += nodes.reject { |n| visited.include?(n) }

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
      # First make sure the node is actually in the graph...
      raise "Node #{node.name} is not in the graph" unless @nodes.include?(node)

      visited = []

      visited << node
      return visited if distance.zero?

      # Recursive is probably the easiest way to do this
      node.edges_out.each do |n|
        visited += depth_first_traversal(n.to, distance: distance - 1)
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
