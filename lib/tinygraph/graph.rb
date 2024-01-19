# Frozen_string_literal: true

# TODO: Implement the following methods
# - [x] Remove node
# - [x] Remove edge
# - [x] Find node by name
# - [x] Find node by id
# - [x] Find edge by from and to
# - [x] Find edge by from
# - [x] Find edge by to
# - [x] Find edge by id
# - [x] find edge by attribute

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

      @index.delete_node(node)
      @nodes.delete(node)
    end

    def delete_edge(edge)
      edge.from.edges_out.delete(edge)
      edge.to.edges_in.delete(edge)

      edge.from = nil
      edge.to = nil

      @index.delete_edge(edge)
    end

    def add_edge(from, to)
      edge = Edge.new(from, to)
      @index.add_edge(edge)
    end

    def find_node(name: nil, id: nil)
      raise "You must provide either a name or an id" if name.nil? && id.nil?

      if name
        @index.find_node_by_name(name)
      else
        @index.find_node_by_id(id)
      end
    end

    def find_edge(from: nil, to: nil, id: nil)
      raise "You must provide either a from, a to, or an id" if from.nil? && to.nil? && id.nil?
      raise "If you provide an id you can't look for other attributes" if id && (from || to)

      if from && to
        @index.find_edge_by_from_and_to(from, to)
      elsif from
        @index.find_edge_by_from(from)
      elsif to
        @index.find_edge_by_to(to)
      else
        @index.find_edge_by_id(id)
      end
    end

    def find_edges_by_attribute(attribute)
      @index.find_edges_by_attribute(attribute)
    end

    def find_edges_by_attributes(attributes = [])
      @index.find_edges_by_attributes(attributes)
    end

    def find_edge_by_attribute_and_value(attribute, value)
      @index.find_edge_by_attribute_and_value(attribute, value)
    end

    def find_edges_by_attributes_and_values(attributes = {})
      @index.find_edges_by_attributes_and_values(attributes)
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
