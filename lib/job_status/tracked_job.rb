module JobStatus
  module TrackedJob
    def self.included(base)
      base.extend ClassMethods
      base.class_eval do
        before_enqueue { JobStatus::Tracker.enqueue(job_id: @job_id) }

        before_perform { JobStatus::Tracker.update(job_id: @job_id, status: :working ) }

        after_perform { JobStatus::Tracker.update(job_id: @job_id, status: :completed ) }
      end
    end

    def at(job_id:, at:)
      cache = JobStatus.store.fetch(job_id)
      cache[:at] = at
      JobStatus.store.write(job_id, cache)
    end

    def total(job_id:, total:)
      cache = JobStatus.store.fetch(job_id)
      cache[:total] = total
      JobStatus.store.write(job_id, cache)
    end

    def store(job_id:, store:)
      cache = JobStatus.store.fetch(job_id)
      cache[:store] = store
      JobStatus.store.write(job_id, cache)
    end

    module ClassMethods
    end
  end
end
