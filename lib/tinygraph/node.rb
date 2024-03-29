# Frozen_string_literal: true

module Tinygraph
  # A node in a graph
  class Node
    attr_accessor :name, :edges_in, :edges_out, :id

    def initialize(name)
      @name = name
      @edges_in = []
      @edges_out = []
      @id = SecureRandom.urlsafe_base64
    end

    def to_s
      "#{@name}:#{@id} -> #{@edges_out.map { |e| "#{e.to.name}:#{@id}, " }}"
    end

    def edges
      @edges_in + @edges_out
    end
  end
end
