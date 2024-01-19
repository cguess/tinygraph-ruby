# frozen_string_literal: true

require "test_helper"

class TestIndex < Minitest::Test
  def test_creating_an_index
    index = Tinygraph::Index.new
    assert index
  end

  def test_finding_a_node_by_name
    index = Tinygraph::Index.new
    node = Tinygraph::Node.new("test node")
    index.add_node(node)
    assert index.find_node_by_name("test node") == node
  end

  def test_finding_a_node_by_id
    index = Tinygraph::Index.new
    node = Tinygraph::Node.new("test node")
    index.add_node(node)
    assert index.find_node_by_id(node.id) == node
  end

  def test_finding_an_edge_by_from_and_to
    index = Tinygraph::Index.new
    from = Tinygraph::Node.new("from")
    to = Tinygraph::Node.new("to")
    edge = Tinygraph::Edge.new(from, to)
    index.add_edge(edge)
    assert index.find_edge_by_from_and_to(from, to) == edge
  end

  def test_finding_an_edge_by_from
    index = Tinygraph::Index.new
    from = Tinygraph::Node.new("from")
    to = Tinygraph::Node.new("to")
    edge = Tinygraph::Edge.new(from, to)
    index.add_edge(edge)
    assert index.find_edge_by_from(from) == edge
  end

  def test_finding_an_edge_by_to
    index = Tinygraph::Index.new
    from = Tinygraph::Node.new("from")
    to = Tinygraph::Node.new("to")
    edge = Tinygraph::Edge.new(from, to)
    index.add_edge(edge)
    assert index.find_edge_by_to(to) == edge
  end
end
