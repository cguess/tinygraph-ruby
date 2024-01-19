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
    assert index.find_by_name("test node") == node
  end

  def test_finding_a_node_by_id
    index = Tinygraph::Index.new
    node = Tinygraph::Node.new("test node")
    index.add_node(node)
    assert index.find_by_id(node.id) == node
  end
end
