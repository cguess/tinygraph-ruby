# frozen_string_literal: true

module Tinygraph
  class Index
    attr_reader :nodes, :edges

    def initialize
      @nodes = []
      @edges = []
    end

    def add_node(node)
      @nodes << node
    end

    def add_edge(edge)
      @edges << edge
    end

    def delete_node(node)
      @nodes.delete(node)
    end

    def delete_edge(edge)
      @edges.delete(edge)
    end

    def find_node_by_name(name)
      @nodes.find { |node| node.name == name }
    end

    def find_node_by_id(id)
      @nodes.find { |node| node.id == id }
    end

    def find_edge_by_from_and_to(from, to)
      @edges.find { |edge| edge.from == from && edge.to == to }
    end

    def find_edge_by_from(from)
      @edges.find { |edge| edge.from == from }
    end

    def find_edge_by_to(to)
      @edges.find { |edge| edge.to == to }
    end
  end
end
