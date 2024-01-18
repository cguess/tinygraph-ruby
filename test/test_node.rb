# frozen_string_literal: true

require "test_helper"

class TestNode < Minitest::Test
  def test_creating_a_node
    node = Tinygraph::Node.new("test node")
    assert node
    assert node.name == "test node"
  end
end
