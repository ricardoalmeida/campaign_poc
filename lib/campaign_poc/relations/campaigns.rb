module CampaignPoc
  module Relations
    class Campaigns < ROM::Relation[:sql]
      schema(:campaigns, infer: true)
    end
  end
end
