# Frozen_string_literal: true

module Tinygraph
  # An edge in a graph
  class Edge
    attr_accessor :from, :to, :id

    def initialize(from, to)
      @from = from
      @to = to
      @id = SecureRandom.urlsafe_base64

      from.edges_out << self
      to.edges_in << self
    end

    def to_s
      "#{@from} -> #{@to}"
    end
  end
end
