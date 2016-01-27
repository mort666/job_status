require 'active_job'

module JobStatus
  class TrackedJob < ActiveJob::Base
    before_enqueue { JobStatus::Tracker.enqueue(job_id: @job_id) }

    before_perform { JobStatus::Tracker.update(job_id: @job_id, status: :working ) }

    after_perform { JobStatus::Tracker.update(job_id: @job_id, status: :completed ) }
  end
end
