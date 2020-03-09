require_relative "boot"

require "dry/system/container"
require "dry/auto_inject"

module CampaignPoc
  class Application < Dry::System::Container
    configure do |config|
      config.root = File.expand_path('..', __dir__)
      config.default_namespace = 'campaign_poc'

      config.auto_register = 'lib'
    end

    load_paths!('lib')
  end

  Import = Dry::AutoInject(Application)
end
