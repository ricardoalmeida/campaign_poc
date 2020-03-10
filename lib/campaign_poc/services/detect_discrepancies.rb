module CampaignPoc
  module Services
    class DetectDiscrepancies
      include Import[
        "repos.campaign_repo",
        "repos.ad_repo",
      ]

      def call
        remotes = ad_repo.all.map { |ad| ad["reference"] }
        campaigns = campaign_repo.query(external_reference: remotes)
        campaigns.to_a.map do |campaign|
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
