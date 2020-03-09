require "spec_helper"

RSpec.describe CampaignPoc::Services::DetectDiscrepancies do
  let(:campaign_repo) { double(CampaignPoc::Repos::CampaignRepo) }

  before do
    repo = CampaignPoc::Repos::CampaignRepo.new
    repo.create(
      ad_description: "Ruby on Rails Developer",
      status: "active",
      external_reference: "1"
    )
    repo.create(
      ad_description: "Golang Developer",
      status: "active",
      external_reference: "2"
    )
  end

  describe ".call" do
    it "returns discrepancies for remotes" do
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
