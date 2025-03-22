require "rails_helper"

RSpec.describe TimeHelper, type: :helper do
  describe "#format" do
    it "handles time that includes seconds"  do
      expect(format_time(30)).to eq "30secs"
    end

    it "handles time that includes mins" do
      expect(format_time(120)).to eq "2mins"
    end

    it "handles time that includes mins and secs" do
      expect(format_time(130)).to eq "2mins 10secs"
    end

    it "handles hours as mins" do
      expect(format_time(3.hours.seconds)).to eq "180mins"
    end
  end
end
