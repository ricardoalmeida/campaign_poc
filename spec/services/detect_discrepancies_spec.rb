require "spec_helper"

RSpec.describe CampaignPoc::Services::DetectDiscrepancies do
  let(:subject) { described_class }
  before do
    repo = CampaignPoc::Repos::CampaignRepo.new
    repo.create(
      ad_description: "Ruby on Rails Developer",
      status: "active",
      external_reference: 1
    )
  end

  describe ".call" do
    it "list campaigns" do
      expect(subject.call).to match([
        {
          "remote_reference": "1",
          "discrepancies": [
            "status": {
              "remote": "disabled",
              "local": "active"
            },
            "description": {
              "remote": "Rails Engineer",
              "local": "Ruby on Rails Developer"
            }
          ]
        }
      ])
    end
  end
end
