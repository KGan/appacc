require 'rspec'
class PolyTreeNode
  attr_accessor :value, :children
  attr_reader :parent
  def initialize(value)
    # options = {:value => 0, :children => [], :parent => nil}.merge(options)
    @value = value #options[:value]
    @children = [] #options[:children]
    @parent = nil #options[:parent]
  end

  def add_child(child_node)
    child_node.parent= self
  end

  def remove_child(child)
    child.parent= nil
  end

  def parent=(parent_node)
    if !@parent.nil?
      @parent.children.delete(self)
    end
    @parent = parent_node

    if parent_node
      @parent.children << self
    end
  end

  def dfs(target_value)
    if target_value == @value
      return self
    else
      return nil if children.empty?
    end

    children.each do |child|
      return_value = child.dfs(target_value)
      return return_value if return_value
    end
    return nil
  end

  def bfs(target_value)
    queue = [self]
    while (current_node = queue.shift)
      return current_node if current_node.value == target_value
      queue += current_node.children
    end

    return nil
  end
end
