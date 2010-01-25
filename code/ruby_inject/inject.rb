class Filter
  def initialize
    @numbers = (1..10).to_a
    @filters = [filter_out_even, filter_divisible_by_three]
  end

  def process_filters
    @filters.inject(@numbers) {|num, fun| fun.call(num)}
  end

  private

  def filter_out_even
    lambda do |numbers|
      numbers.find_all {|num| num.odd?}
    end
  end

  def filter_divisible_by_three
    lambda do |numbers|
      numbers.find_all {|num| (num % 3) != 0} 
    end
  end

end
