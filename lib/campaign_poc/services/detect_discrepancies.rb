module CampaignPoc
  module Services
    class DetectDiscrepancies

      def self.call
        campaign_repo = CampaignPoc::Repos::CampaignRepo.new
        campaigns = campaign_repo.all
        campaigns.map do |campaign|
          {
            "remote_reference": campaign.external_reference,
            "discrepancies": [
              "status": {
                "remote": "disabled",
                "local": campaign.status,
              },
              "description": {
                "remote": "Rails Engineer",
                "local": campaign.ad_description,
              }
            ]
          }
        end
      end
    end
  end
end
