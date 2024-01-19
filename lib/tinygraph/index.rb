# frozen_string_literal: true

module Tinygraph
  class Index
    attr_reader :nodes

    def initialize
      @nodes = []
    end

    def add_node(node)
      @nodes << node
    end

    def find_by_name(name)
      @nodes.find { |node| node.name == name }
    end

    def find_by_id(id)
      @nodes.find { |node| node.id == id }
    end
  end
end
