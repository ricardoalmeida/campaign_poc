require "spec_helper"

RSpec.describe CampaignPoc::Services::DetectDiscrepancies do
  subject { described_class.new(ad_repo: ad_repo) }
  let(:ad_repo) { double(CampaignPoc::Repos::AdRepo, all: ads_json) }
  let(:ads_json) { json_fixture(:ads) }
  let(:repo) { CampaignPoc::Repos::CampaignRepo.new }
  let(:synchronized) do
    {
      ad_description: "mock campaign 2",
      status: "disabled",
      external_reference: "2"
    }
  end
  let(:discrepant_1) do
    {
      ad_description: "Ruby on Rails Developer",
      status: "active",
      external_reference: "1"
    }
  end
  let(:discrepant_2) do
    {
      ad_description: "mock campaign 3",
      status: "active",
      external_reference: "3"
    }
  end
  let(:not_remote) do
    {
      ad_description: "Golang Developer",
      status: "active",
      external_reference: "4"
    }
  end

  describe ".call" do
    context "synchronized" do
      before do
        repo.create(synchronized)
      end

      it "doesn't return discrepancies" do
        expect(subject.call).to match([])
      end
    end

    context "discrepant" do
      before do
        repo.create(discrepant_1)
      end

      it "returns discrepancies" do
        expect(subject.call).to match([
          {
            remote_reference: "1",
            discrepancies: {
              ad_description: {
                local: "Ruby on Rails Developer",
                remote: "mock campaign 1",
              },
              status: {
                local: "active",
                remote: "enabled",
              },
            }
          },
        ])
      end
    end

    context "not remote" do
      before do
        repo.create(not_remote)
      end

      it "doesn't return discrepancies" do
        expect(subject.call).to match([])
      end
    end

    context "all together" do
      before do
        repo.create(discrepant_1)
        repo.create(synchronized)
        repo.create(discrepant_2)
        repo.create(not_remote)
      end

      it "returns discrepancies" do
        expect(subject.call).to match([
          {
            remote_reference: "1",
            discrepancies: {
              ad_description: {
                local: "Ruby on Rails Developer",
                remote: "mock campaign 1",
              },
              status: {
                local: "active",
                remote: "enabled",
              },
            }
          },
          {
            remote_reference: "3",
            discrepancies: {
              status: {
                local: "active",
                remote: "enabled",
              },
            }
          }
        ])
      end
    end
  end
end
