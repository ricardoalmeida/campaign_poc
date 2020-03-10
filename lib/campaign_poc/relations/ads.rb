module CampaignPoc
  module Relations
    class Ads < ROM::Relation[:http]
      schema(:ads) do
        attribute :ads, ROM::Types::Array do
          attribute :reference, ROM::Types::String
          attribute :status, ROM::Types::String
          attribute :description, ROM::Types::String
        end
      end

      def endpoint
        append_path("5e6801173000005e003278bf")
      end

      auto_struct(true)
    end
  end
end
