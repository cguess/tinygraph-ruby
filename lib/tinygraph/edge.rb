# Frozen_string_literal: true

module Tinygraph
  # An edge in a graph
  class Edge
    attr_accessor :from, :to, :id, :attributes

    def initialize(from, to)
      @from = from
      @to = to
      @id = SecureRandom.urlsafe_base64
      @attributes = {}

      from.edges_out << self
      to.edges_in << self
    end

    def add_attribute(key, value)
      @attributes[key.to_sym] = value
    end

    def attribute?(key)
      @attributes.key?(key.to_sym)
    end

    def attribute(key)
      @attributes[key.to_sym]
    end

    def delete_attribute(key)
      @attributes.delete(key.to_sym)
    end

    def delete_attributes(keys)
      keys.each { |key| delete_attribute(key.to_sym) }
    end

    def delete_all_attributes
      @attributes = {}
    end

    def delete_attribute_if(&block)
      @attributes.delete_if(&block)
    end

    def to_s
      "#{@from} -> #{@to}"
    end
  end
end
