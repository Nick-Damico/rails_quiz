require "rails_helper"

RSpec.describe QuestionHelper, type: :helper do
  describe "#num_to_letter" do
    it 'converts a number to a letter' do
      expect(num_to_letter(0)).to eq 'a'
    end

    it 'handles String representations of numbers without error' do 
      expect(num_to_letter('0')).to eq 'a'
    end

    context 'alphabetical letter range' do
      it 'returns nil for negative numbers less than the range' do
        expect(num_to_letter(-1)).to be_nil
      end

      it 'returns nil for numbers greater than the range' do
        expect(num_to_letter(27)).to be_nil
      end

      it 'returns the letter within the range' do
        expect(num_to_letter(25)).to eq 'z'
      end
    end
  end
end
