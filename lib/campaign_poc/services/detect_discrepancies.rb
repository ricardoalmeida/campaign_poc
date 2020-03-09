module CampaignPoc
  module Services
    class DetectDiscrepancies
      include Import[
        "repos.campaign_repo"
      ]

      def call
        remotes = ["1"]
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
