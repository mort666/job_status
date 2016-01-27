module JobStatus
  #
  # Tracking routines used by the callbacks
  #
  module Tracker
    #
    # Sets the initial queued worker status and sets the expiry
    #
    # @param job_id [String] ActiveJob ID to use as the key in storage
    #
    def self.enqueue(job_id:)
      JobStatus.store.write(job_id, {status: :queued, at: 0, total: 100}, expires_in: 259200)
    end

    #
    # Stores the current status within the storage
    #
    # @param job_id [String] ActiveJob ID to use as the key in storage
    #
    def self.update(job_id:, status:)
      cache = JobStatus.store.fetch(job_id)
      cache[:status] = status
      JobStatus.store.write(job_id, cache)
    end

    #
    # Removes any information from the cache for the given job_id
    #
    # @param job_id [String] ActiveJob ID to use as the key in storage
    #
    def self.remove(job_id:)
      JobStatus.store.delete(job_id)
    end
  end
end
