require 'spec_helper'
require 'generator'

describe 'An object that extends Generator' do
  let(:gen) { Object.new.tap { |o| o.extend(Generator) } }

  describe '#maybe' do
    context 'with no parameters' do
      it 'calls its block half the time' do
        call_count = 0
        1000.times { gen.maybe { call_count += 1 } }
        expect(call_count).to be_within(30).of(500)
      end
    end

    context 'with a probability parameter' do
      it "calls its block P% of the time \
                     (well, it's not a percentage, but you know what I mean)" do
        call_count = 0
        1000.times { gen.maybe(0.27) { call_count += 1 } }
        expect(call_count).to be_within(30).of(270)
      end
    end
  end

  describe '#a' do
    context 'when its word starts with a vowel' do
      it 'prepends "an"' do
        %w(apple egg inch orb urn).each do |word|
          expect(gen.a(word)).to eq "an #{word}"
        end
      end
    end

    context 'when its word starts with a non-vowel letter' do
      it 'prepends "a"' do
        %w(berry coffee donut fig grape letter maple pea).each do |word|
          expect(gen.a(word)).to eq "a #{word}"
        end
      end
    end

    context 'when its word starts with whitespace' do
      it "skips past the whitespace (but doesn't strip it)" do
        expect(gen.a(' egg')).to eq 'an  egg'
        expect(gen.a("\tbug")).to eq "a \tbug"
      end
    end
  end

  describe '#pick_one' do
    context 'when passed anything besides callables' do
      it 'picks one at random' do
        counts = Hash.new
        choices = %i(a b c d)
        1000.times do
          choice = gen.pick_one(*choices)
          counts[choice] = 1 + counts.fetch(choice, 0)
        end

        choices.each do |choice|
          expect(counts[choice]).to be_within(40).of(250)
        end
      end
    end

    context 'when passed callables' do
      it 'picks one at random and calls it' do
        counts = Hash.new
        choices = [
          -> { :a },
          -> { :b },
          -> { :c },
          -> { :d }
        ]
        1000.times do
          choice = gen.pick_one(*choices)
          counts[choice] = 1 + counts.fetch(choice, 0)
        end

        %i(a b c d).each do |choice|
          expect(counts[choice]).to be_within(40).of(250)
        end
      end
    end
  end
end
