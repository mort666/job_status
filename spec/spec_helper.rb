require 'bundler'
require 'job_status'

include ActiveJob::TestHelper

require "active_support/testing/time_helpers"

include ActiveSupport::Testing::TimeHelpers

ActiveJob::Base.queue_adapter = :test

JobStatus.store = ActiveSupport::Cache::MemoryStore.new

require 'support/my_job'
