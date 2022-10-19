# frozen_string_literal: true

redis_connection_params = { host: Rails.application.config_for(:redis).host,
                            port: Rails.application.config_for(:redis).port,
                            username: Rails.application.config_for(:redis).username,
                            password: Rails.application.config_for(:redis).password,
                            database: Rails.application.config_for(:redis).database,
                            ssl: Rails.application.config_for(:redis).ssl }

Sidekiq.configure_server do |config|
  config.redis = redis_connection_params
end

Sidekiq.configure_client do |config|
  config.redis = redis_connection_params
end
