

class RandomUtil
  class << self
    def select_weighted(hsh)
      # roll randomly on the sum of values
      roll = rand(hsh.values.inject(0) { |sum, v| sum += v }) 
      #puts "rolled #{roll}"
      index = 0
      hsh.each do |k, v|
        index += v
        return k if index > roll
      end
    end

    def select_equal(collection)
      case collection
      when Hash
        collection[collection.keys[rand(collection.size)]]
      when Array
        collection[rand(collection.size)]
      end
    end
  end
end




