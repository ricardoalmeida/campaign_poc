require "spec_helper"

RSpec.describe CampaignPoc::Services::DetectDiscrepancies do
  let(:subject) { described_class }
  describe ".call" do
    it "responds to call" do
      subject.call
    end
  end
end
