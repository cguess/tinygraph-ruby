# frozen_string_literal: true

require "test_helper"

class TestGraph < Minitest::Test
  def test_creating_a_graph
    graph = Tinygraph::Graph.new
    assert graph
  end

  def test_adding_a_node_to_a_graph
    graph = Tinygraph::Graph.new
    node = Tinygraph::Node.new("test node")
    graph.add_node(node)
    assert graph.nodes.include?(node)
  end

  def test_find_node_by_name
    graph = build_big_graph
    assert graph.find_node(name: "node3")
  end

  def test_find_node_by_id
    graph = build_big_graph
    node = graph.nodes[3]
    assert graph.find_node(id: node.id)
  end

  def test_find_edge_by_from_and_to
    graph = build_big_graph
    node1 = graph.find_node(name: "node1")
    node2 = graph.find_node(name: "node2")
    assert graph.find_edge(from: node1, to: node2)
  end

  def test_find_edge_by_from
    graph = build_big_graph
    node1 = graph.find_node(name: "node1")
    assert graph.find_edge(from: node1)
  end

  def test_find_edge_by_to
    graph = build_big_graph
    node2 = graph.find_node(name: "node2")
    assert graph.find_edge(to: node2)
  end

  def test_delete_edge
    graph = build_big_graph
    node = graph.find_node(name: "node3")
    edge = node.edges_in.first

    graph.delete_edge(edge)
    assert !node.edges.include?(edge)
  end

  def test_delete_node
    graph = build_big_graph
    node = graph.find_node(name: "node3")

    graph.delete_node(node)
    assert !graph.nodes.include?(node)

    assert_nil graph.find_node(name: "node3")
  end

  def test_graph_traversal
    graph = build_big_graph
    node = graph.nodes.first

    assert_equal [
      "node1", "node2", "node3", "node4", "node5", "node6",
      "node7", "node8", "node9"
    ], graph.breadth_first_traversal(node).map(&:name)

    assert_equal [
      "node1", "node2", "node5", "node6", "node3",
      "node7", "node8", "node4", "node9"
    ], graph.depth_first_traversal(node).map(&:name)
  end

  def test_graph_depth_first_traversal_with_distance
    graph = build_big_graph
    node = graph.nodes.first

    assert_equal [
      "node1", "node2", "node3", "node4"
    ], graph.depth_first_traversal(node, distance: 1).map(&:name)

    assert_equal [
      "node1", "node2", "node5", "node6", "node3", "node7", "node8", "node4", "node9"
    ], graph.depth_first_traversal(node, distance: 2).map(&:name)
  end

  def test_graph_breadth_first_traversal_with_distance
    graph = build_big_graph
    node = graph.nodes.first

    assert_equal [
      "node1", "node2", "node3", "node4"
    ], graph.breadth_first_traversal(node, distance: 1).map(&:name)

    assert_equal [
      "node1", "node2", "node3", "node4", "node5", "node6", "node7", "node8", "node9"
    ], graph.breadth_first_traversal(node, distance: 3).map(&:name)
  end

  def build_big_graph
    graph = Tinygraph::Graph.new

    node1 = Tinygraph::Node.new("node1")
    node2 = Tinygraph::Node.new("node2")
    node3 = Tinygraph::Node.new("node3")
    node4 = Tinygraph::Node.new("node4")
    node5 = Tinygraph::Node.new("node5")
    node6 = Tinygraph::Node.new("node6")
    node7 = Tinygraph::Node.new("node7")
    node8 = Tinygraph::Node.new("node8")
    node9 = Tinygraph::Node.new("node9")

    graph.add_node(node1)
    graph.add_node(node2)
    graph.add_node(node3)
    graph.add_node(node4)
    graph.add_node(node5)
    graph.add_node(node6)
    graph.add_node(node7)
    graph.add_node(node8)
    graph.add_node(node9)

    graph.add_edge(node1, node2)
    graph.add_edge(node1, node3)
    graph.add_edge(node1, node4)
    graph.add_edge(node2, node5)
    graph.add_edge(node2, node6)
    graph.add_edge(node3, node7)
    graph.add_edge(node3, node8)
    graph.add_edge(node4, node9)

    graph
  end
end
