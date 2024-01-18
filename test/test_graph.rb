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

  def test_graph_traversal
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

    assert_equal [
      "node1", "node2", "node3", "node4", "node5", "node6",
      "node7", "node8", "node9"
    ], graph.breadth_first_traversal(node1).map(&:name)

    assert_equal [
      "node1", "node2", "node5", "node6", "node3",
      "node7", "node8", "node4", "node9"
    ], graph.depth_first_traversal(node1).map(&:name)
  end

  def test_graph_depth_first_traversal_with_distance
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

    assert_equal [
      "node1", "node2", "node3", "node4"
    ], graph.depth_first_traversal(node1, distance: 1).map(&:name)

    assert_equal [
      "node1", "node2", "node5", "node6", "node3", "node7", "node8", "node4", "node9"
    ], graph.depth_first_traversal(node1, distance: 2).map(&:name)
  end

  def test_graph_breadth_first_traversal_with_distance
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

    assert_equal [
      "node1", "node2", "node3", "node4"
    ], graph.breadth_first_traversal(node1, distance: 1).map(&:name)

    assert_equal [
      "node1", "node2", "node3", "node4", "node5", "node6", "node7", "node8", "node9"
    ], graph.breadth_first_traversal(node1, distance: 3).map(&:name)
  end
end
