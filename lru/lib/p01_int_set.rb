class MaxIntSet
  attr_reader :store

  def initialize(max)
    @store = Array.new(max, false)

  end

  def insert(num)
    validate!(num)
    self.store[num] = true
    self.store[num]
  end

  def remove(num)
    validate!(num)
    self.store[num] = false
  end

  def include?(num)
    self.store[num]
  end

  private

  def is_valid?(num)
    return false unless num.is_a?(Integer)
    num > 0 && num <= self.store.length
  end

  def validate!(num)
    unless is_valid?(num)
      raise "Out of bounds"
    end
  end
end


class IntSet
  attr_reader :store
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num unless include?(num)
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    i = num % num_buckets
    self.store[i]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_accessor :count, :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if self.count == num_buckets
    unless include?(num)
      self[num] << num
      self.count += 1
    end
  end

  def remove(num)
    if include?(num)
      self.count -= 1
      self[num].delete(num)
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    i = num % num_buckets
    self.store[i]
  end


  def num_buckets
    self.store.length
  end

  def resize!
    self.count = 0
    remove_array = []

    self.store.each do |bucket|
      bucket.each do |num|
        remove_array << num
      end
    end
    self.store = Array.new(num_buckets * 2) { Array.new}
    remove_array.each do |num|
      insert(num)
    end
  end

end
