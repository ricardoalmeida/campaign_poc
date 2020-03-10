module CampaignPoc
  module Repos
    class AdRepo < ROM::Repository
      include Import["container"]

      def all
        rom.relations[:ads].endpoint.one.ads
      end

      private

      def rom
        return @rom unless @rom.nil?

        config = ROM::Configuration.new(:http, uri: uri, handlers: :json)
        config.register_relation(CampaignPoc::Relations::Ads)
        @rom = ROM.container(config)
      end

      def uri
        "http://www.mocky.io/v2/"
      end
    end
  end
end
