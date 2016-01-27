$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'job_status'

require 'minitest/autorun'

include ActiveJob::TestHelper

require "active_support/testing/time_helpers"

include ActiveSupport::Testing::TimeHelpers

ActiveJob::Base.queue_adapter = :test
