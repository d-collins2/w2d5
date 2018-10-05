class HashSet
  attr_reader :count, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    val = key.hash
    self[key] << val
    @count += 1
    resize! if @count > num_buckets
  end

  def include?(key)
     val = key.hash
    self[key].include?(val)
  end

  def remove(key)
    val = key.hash
    if self[key].include?(val)
      self[key].delete(val)
      @count -= 1
    end
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    num = num.hash
    i = num % num_buckets
    self.store[i]
  end

  def num_buckets
    @store.length
  end

  def resize!
    temp = []
    @store.each do |bucket|
      bucket.each do |val|
        temp << val
      end
    end
    @store = Array.new(num_buckets * 2){ Array.new }
    @count = 0
    temp.each {|val| self.insert(val) }
  end
end
