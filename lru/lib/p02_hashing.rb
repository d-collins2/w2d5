class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    return 0 if self.empty?
    self.reduce { |acc, n| acc += n.hash }
  end
end

class String
  def hash
    self.chars.map { |e| e.ord }.hash

  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    self.to_a.sort.flatten.map do |el|
      if el.is_a?(Symbol)
        el = el.to_s.ord
      elsif el.is_a?(String)
        el = el.ord
      end
    end
    .hash
  end
end
