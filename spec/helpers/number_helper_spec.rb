require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the NumberHelper. For example:
#
# describe NumberHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe NumberHelper, type: :helper do
  describe "#format_as_two_digits" do
    it "formats Number to String" do
      expect(format_as_two_digits(1)).to be_a(String)
    end

    it "formats single digit numbers to two digits" do
      expect(format_as_two_digits(1)).to eq("01")
    end

    it "returns numbers with two or more digits unchanged" do
      expect(format_as_two_digits(50)).to eq("50")
      expect(format_as_two_digits(100)).to eq("100")
    end
  end
end
