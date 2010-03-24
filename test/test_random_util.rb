
require 'test/unit'
require '../lib/random_util'

class RandomUtilTest < Test::Unit::TestCase

  def test_select_weighted
    assert RandomUtil.select_weighted({ :a => 1 }), :a
    assert [:a, :b].include?(RandomUtil.select_weighted( { :a => 1, :b => 1 } ))
  end

  def test_probabilistic_rolling
    # Weighted array selection
    #
    items = { 
      :a => 1.0, 
      :b => 1.0, 
      :c => 2.0, 
      :d => 1.0, 
      :e => 1.0, 
      :f => 2.0, 
      :g => 2.0 
    }
    trials = 5 
    samples = 10000.0 # Things slow way down with 100K samples
    error_bound = 0.10 # 10% seems fair?
    total_weight = items.inject(0.0) { |total, (k, v)| total += v }
    trials.times do
      checklist = { # reset the experiment
        :a => 0, 
        :b => 0, 
        :c => 0, 
        :d => 0, 
        :e => 0, 
        :f => 0, 
        :g => 0 
      }
      samples.to_i.times { checklist[RandomUtil.select_weighted(items)] += 1 }
      checklist.each do |k, v|
        prob_total = (items[k] / total_weight) * samples
        delta = prob_total * error_bound
        lower, upper = prob_total - delta, prob_total + delta
        #puts "Calculating #{k}: #{v}"
        #puts "#{[lower..upper]} === #{checklist[k]}"
        assert (lower..upper) === checklist[k], "#{checklist[k]} was not in the range (#{lower}..#{upper})!"
      end
    end
  end

end
