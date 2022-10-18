# frozen_string_literal: true

Sidekiq.configure_server do |config|
  config.redis = { host: Rails.application.config_for(:redis).host,
                   port: Rails.application.config_for(:redis).port }
end

Sidekiq.configure_client do |config|
  config.redis = { host: Rails.application.config_for(:redis).host,
                   port: Rails.application.config_for(:redis).port }
end
