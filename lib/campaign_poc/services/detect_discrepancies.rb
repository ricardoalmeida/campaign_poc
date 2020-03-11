module CampaignPoc
  module Services
    class DetectDiscrepancies

      include Import[
        "repos.campaign_repo",
        "repos.ad_repo",
      ]

      def call
        campaigns = campaign_repo.query(
          external_reference: remote_ads.map { |ad| ad["reference"] }
        )

        campaigns.map { |campaign| discrepancy_for(campaign) }.compact
      end

      private

      def remote_ads
        @remote_ads ||= ad_repo.all
      end

      def detect_ad_by(reference:)
        remote_ads.detect { |ad| ad["reference"] == reference }
      end

      def discrepancy_for(campaign)
        ad = mapper(detect_ad_by(reference: campaign.external_reference))
        discrepancy = whitelist_for(campaign.attributes).to_a - whitelist_for(ad).to_a
        if discrepancy.any?
          discrepancy_json(campaign: campaign, ad: ad, attributes: discrepancy.map { |d| d[0] })
        end
      end

      # It can go to a serializer class
      def discrepancy_json(campaign:, ad:, attributes:)
        discrepancy = {}
        attributes.each do |attribute|
          discrepancy[attribute] = {
            local: campaign[attribute],
            remote: ad[attribute]
          }
        end
        {
          remote_reference: campaign.external_reference,
          discrepancies: discrepancy
        }
      end

      def whitelist_for(entity)
        entity.slice(:ad_description, :status)
      end

      # It can go to a mapper class
      def mapper(ad)
        {
          status: ad["status"],
          ad_description: ad["description"]
        }
      end
    end
  end
end
