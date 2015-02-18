class MyHashSet
  attr_accessor :store

  def initialize
    @store = {}
  end

  def insert(el)
    @store[el] = true
  end

  def include?(el)
    @store.key?(el)
  end

  def delete(el)
    if @store.delete(el)
      return true
    end
    false
  end

  def to_a
    @store.keys
  end

  def union(set2)
    newset = MyHashSet.new
    newset.store.merge!(store.merge(set2.store))
    newset
  end

  def intersect(set2)
    newset = MyHashSet.new
    store.each_key do |key|
      newset.insert(key) if set2.include?(key)
    end
    newset
  end

  def minus(set2)
    newset = MyHashSet.new
    store.each_key do |key|
      newset.insert(key) unless set2.include?(key)
    end
    newset
  end
end
