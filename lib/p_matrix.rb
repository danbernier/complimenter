class PMatrix
  def initialize(p_hash)
    @cumulative = cumulative(normalize(p_hash))
  end

  def sample
    r = rand
    @cumulative.find { |key, weight| r <= weight }[0]
  end

  private

  def normalize(p_hash)
    total_p = p_hash.values.reduce(:+).to_f
    Hash[p_hash.sort_by(&:last).reverse.map { |k, p| [k, p/total_p] }]
  end

  def cumulative(p_hash)
    accum = 0
    p_hash.map { |k, p| [k, accum += p] }
  end
end
