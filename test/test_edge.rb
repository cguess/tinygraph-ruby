# frozen_string_literal: true

require "test_helper"

class TestEdge < Minitest::Test
  def test_creating_an_edge
    node_from = Tinygraph::Node.new("test node from")
    node_to = Tinygraph::Node.new("test node to")
    edge = Tinygraph::Edge.new(node_from, node_to)
    assert edge
    assert edge.from == node_from
    assert edge.to == node_to

    assert node_from.edges_out.include?(edge)
    assert node_to.edges_in.include?(edge)
  end
end
