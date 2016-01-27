module JobStatus
  module Tracker
    def self.enqueue(job_id:)
      JobStatus.store.write(job_id, {status: :queued, at: 0, total: 100}, expires_in: 259200)
    end

    def self.update(job_id:, status:)
      cache = JobStatus.store.fetch(job_id)
      cache[:status] = status
      JobStatus.store.write(job_id, cache)
    end

    def self.remove(job_id:)
      JobStatus.store.delete(job_id)
    end

    def self.at(job_id:, at:)
      cache = JobStatus.store.fetch(job_id)
      cache[:at] = at
      JobStatus.store.write(job_id, cache)
    end

    def self.total(job_id:, total:)
      cache = JobStatus.store.fetch(job_id)
      cache[:total] = total
      JobStatus.store.write(job_id, cache)
    end

    def self.store(job_id:, store:)
      cache = JobStatus.store.fetch(job_id)
      cache[:store] = store
      JobStatus.store.write(job_id, cache)
    end
  end
end
