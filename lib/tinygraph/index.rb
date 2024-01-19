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

    def find_edge_by_id(id)
      @edges.find { |edge| edge.id == id }
    end

    def find_edges_by_attribute(attribute)
      @edges.select { |edge| edge.attribute?(attribute) }
    end

    def find_edges_by_attributes(attributes = [])
      @edges.select do |edge|
        valid = true
        attributes.each do |attribute|
          valid = false unless edge.attribute?(attribute)
        end

        valid
      end
    end

    def find_edge_by_attribute_and_value(attribute, value)
      @edges.find do |edge|
        edge.attribute?(attribute) && edge.attribute(attribute) == value
      end
    end

    def find_edge_by_attributes_and_values(attributes = {})
      @edges.each do |edge|
        valid = false

        attributes.each do |key, value|
          valid = true if edge.attribute?(key) &&
                          edge.attribute(key) == value
        end

        return edge if valid
      end
    end

    def find_edges_by_attribute_and_value(attribute, value)
      @edges.select do |edge|
        edge.attribute?(attribute) && edge.attribute(attribute) == value
      end
    end

    def find_edges_by_attributes_and_values(attributes = {})
      @edges.select do |edge|
        valid = true

        attributes.each do |key, value|
          valid = false unless edge.attribute?(key) &&
                               edge.attribute(key) == value
        end

        valid
      end
    end
  end
end
