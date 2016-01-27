require 'active_job'

require 'job_status/tracker'
require 'job_status/tracked_job'
require 'job_status/status'

require "job_status/version"

#
# ActiveJob Status Module Namespace
#
module JobStatus
  #
  # Adds the storage for the Cache 
  #
  # @attr store storage for the ActiveSupport::Cache cache handler
  #   Options include ActiveSupport::Cache::MemoryStore
  #                   ActiveSupport::Cache::RedisStore
  class << self
    attr_accessor :store
  end
end
