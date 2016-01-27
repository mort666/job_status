require 'active_job'

require 'job_status/tracker'
require 'job_status/tracked_job'
require 'job_status/status'

require "job_status/version"

module JobStatus
  class << self
    attr_accessor :store
  end
end
