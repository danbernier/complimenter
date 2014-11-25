require 'spec_helper'
require 'p_matrix'

describe PMatrix do
  it 'returns values proportionally to their weights' do
    weights = { a: 49, b: 29, c: 72 }
    total_weight = 49 + 29 + 72

    pmatrix = PMatrix.new(weights)

    counts = Hash.new
    1000.times do
      chosen = pmatrix.sample
      counts[chosen] = counts.fetch(chosen, 0) + 1
    end

    expect(counts.keys).to match_array %i(a b c)
    expect(counts[:a] / 1000.0).to be_within(0.1).of(49.0 / total_weight)
    expect(counts[:b] / 1000.0).to be_within(0.1).of(29.0 / total_weight)
    expect(counts[:c] / 1000.0).to be_within(0.1).of(72.0 / total_weight)
  end
end
