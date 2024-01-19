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

  def test_finding_an_edge_by_id
    index = Tinygraph::Index.new
    from = Tinygraph::Node.new("from")
    to = Tinygraph::Node.new("to")
    edge = Tinygraph::Edge.new(from, to)
    index.add_edge(edge)
    assert index.find_edge_by_id(edge.id) == edge
  end

  def test_finding_edges_by_attribute
    index = Tinygraph::Index.new
    from = Tinygraph::Node.new("from")
    to = Tinygraph::Node.new("to")
    edge = Tinygraph::Edge.new(from, to)
    edge.add_attribute("test attribute", "test value")
    index.add_edge(edge)
    assert index.find_edges_by_attribute("test attribute").include?(edge)
  end

  def test_finding_edges_by_attributes
    index = Tinygraph::Index.new
    from = Tinygraph::Node.new("from")
    to = Tinygraph::Node.new("to")
    edge = Tinygraph::Edge.new(from, to)
    edge.add_attribute("test attribute", "test value")
    edge.add_attribute("test attribute 2", "test value 2")
    index.add_edge(edge)
    assert index.find_edges_by_attributes(["test attribute", "test attribute 2"]).include?(edge)
  end

  def test_finding_an_edge_by_attribute_and_value
    index = Tinygraph::Index.new
    from = Tinygraph::Node.new("from")
    to = Tinygraph::Node.new("to")
    edge = Tinygraph::Edge.new(from, to)
    edge.add_attribute("test attribute", "test value")
    index.add_edge(edge)
    assert index.find_edge_by_attribute_and_value("test attribute", "test value") == edge
  end

  def test_finding_an_edge_by_attributes_and_values
    index = Tinygraph::Index.new
    from = Tinygraph::Node.new("from")
    to = Tinygraph::Node.new("to")
    edge = Tinygraph::Edge.new(from, to)
    edge.add_attribute("test attribute", "test value")
    edge.add_attribute("test attribute 2", "test value 2")
    index.add_edge(edge)

    assert index.find_edge_by_attributes_and_values({ "test attribute": "test value",
                                                      "test attribute 2": "test value 2" }) == edge
  end

  def test_finding_edges_by_attributes_and_values
    index = Tinygraph::Index.new
    from = Tinygraph::Node.new("from")
    to = Tinygraph::Node.new("to")
    edge1 = Tinygraph::Edge.new(from, to)
    edge1.add_attribute("test attribute", "test value")
    edge1.add_attribute("test attribute 2", "test value 2")
    edge2 = Tinygraph::Edge.new(from, to)
    edge2.add_attribute("test attribute", "test value")
    edge2.add_attribute("test attribute 2", "test value 2")
    index.add_edge(edge1)
    index.add_edge(edge2)
    assert index.find_edges_by_attributes_and_values({ "test attribute": "test value",
                                                       "test attribute 2": "test value 2" }).include?(edge1)
    assert index.find_edges_by_attributes_and_values({ "test attribute": "test value",
                                                       "test attribute 2": "test value 2" }).include?(edge2)
  end
end
