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

  def test_adding_an_attribute_to_an_edge
    node_from = Tinygraph::Node.new("test node from")
    node_to = Tinygraph::Node.new("test node to")
    edge = Tinygraph::Edge.new(node_from, node_to)
    edge.add_attribute("test attribute", "test value")
    assert edge.attribute("test attribute") == "test value"
  end

  def test_checking_for_an_attribute_on_an_edge
    node_from = Tinygraph::Node.new("test node from")
    node_to = Tinygraph::Node.new("test node to")
    edge = Tinygraph::Edge.new(node_from, node_to)
    edge.add_attribute("test attribute", "test value")
    assert edge.attribute?("test attribute")
  end

  def test_deleting_an_attribute_from_an_edge
    node_from = Tinygraph::Node.new("test node from")
    node_to = Tinygraph::Node.new("test node to")
    edge = Tinygraph::Edge.new(node_from, node_to)
    edge.add_attribute("test attribute", "test value")
    edge.delete_attribute("test attribute")
    assert !edge.attribute?("test attribute")
  end

  def test_deleting_all_attributes_from_an_edge
    node_from = Tinygraph::Node.new("test node from")
    node_to = Tinygraph::Node.new("test node to")
    edge = Tinygraph::Edge.new(node_from, node_to)
    edge.add_attribute("test attribute", "test value")
    edge.add_attribute("test attribute 2", "test value 2")
    edge.delete_all_attributes
    assert !edge.attribute?("test attribute")
    assert !edge.attribute?("test attribute 2")
  end

  def test_deleting_attributes_from_an_edge
    node_from = Tinygraph::Node.new("test node from")
    node_to = Tinygraph::Node.new("test node to")
    edge = Tinygraph::Edge.new(node_from, node_to)
    edge.add_attribute("test attribute", "test value")
    edge.add_attribute("test attribute 2", "test value 2")
    edge.delete_attributes(["test attribute", "test attribute 2"])
    assert !edge.attribute?("test attribute")
    assert !edge.attribute?("test attribute 2")
  end

  def test_deleting_attributes_from_an_edge_if_a_block_is_given
    node_from = Tinygraph::Node.new("test node from")
    node_to = Tinygraph::Node.new("test node to")
    edge = Tinygraph::Edge.new(node_from, node_to)
    edge.add_attribute("test attribute", "test value")
    edge.add_attribute("test attribute 2", "test value 2")
    edge.delete_attribute_if { |key, _| key == :"test attribute" }
    assert !edge.attribute?("test attribute")
    assert edge.attribute?("test attribute 2")
  end
end
