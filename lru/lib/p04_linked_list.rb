require "byebug"
class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    self.prev.next = self.next
    self.next.prev = self.prev
  end
end

class LinkedList
  include Enumerable
  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    self.each{ |node| return node.val if node.key == key }
  end

  def include?(key)
    self.each{ |node| return true if node.key == key }
    false
  end

  def append(key, val)
    new_node = Node.new(key, val)
    last.next = new_node
    new_node.prev = last
    @tail.prev = new_node
    new_node.next = @tail

  end

  def update(key, val)
    self.each do |node|
      if node.key == key
        node.val = val
      end
    end

  end

  def remove(key)
    self.each do |node|
     if node.key == key
       node.remove
       update(key, nil)
     end
   end
  end

  def each(&prc)
    curr_el = first
    while curr_el != @tail
      prc.call(curr_el)
      curr_el = curr_el.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
