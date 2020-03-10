CampaignPoc::Application.boot(:db) do
  init do
    require "rom"
    require "rom-sql"
    require 'rom-http'

    register('db.config', ROM::Configuration.new(:sql, ENV['DATABASE_URL']))
  end
end
