module CampaignPoc
  module Repos
    class CampaignRepo < ROM::Repository[:campaigns]
      include Import["container"]

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

      def query(conditions)
        campaigns.where(conditions)
      end
    end
  end
end
