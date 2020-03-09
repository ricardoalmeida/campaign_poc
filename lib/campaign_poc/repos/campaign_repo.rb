module CampaignPoc
  module Repos
    class CampaignRepo < ROM::Repository[:campaigns]
      commands :create,
        use: :timestamps,
        plugins_options: {
          timestamps: {
            timestamps: %i(created_at updated_at)
          }
        }

      def all
        campaigns.to_a
      end
    end
  end
end
