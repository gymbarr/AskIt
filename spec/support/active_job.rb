# frozen_string_literal: true

RSpec.configure do |config|
  config.include ActiveJob::TestHelper

  config.before do
    clear_enqueued_jobs
  end
end
