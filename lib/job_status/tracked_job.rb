module JobStatus
  #
  # Methods to be included within a worker when this module is used with the
  # include keyword
  #
  module TrackedJob
    #
    # Setup the callbacks within the worker class
    #
    # @param base base class which will be extended by this module
    #
    def self.included(base)
      base.extend ClassMethods
      base.class_eval do
        before_enqueue { JobStatus::Tracker.enqueue(job_id: @job_id) }

        before_perform { JobStatus::Tracker.update(job_id: @job_id, status: :working ) }

        after_perform { JobStatus::Tracker.update(job_id: @job_id, status: :completed ) }
      end
    end

    #
    # Store the current position
    #
    # @param job_id [String] ActiveJob job_id to attach information to in storage
    # @param at [Integer] Value to store for the current position
    #
    def at(job_id:, at:)
      cache = JobStatus.store.fetch(job_id)
      cache[:at] = at
      JobStatus.store.write(job_id, cache)
    end

    #
    # Store the the total for the job
    #
    # @param job_id [String] ActiveJob job_id to attach information to in storage
    # @param total [Integer] Value to store for the total positions
    #
    def total(job_id:, total:)
      cache = JobStatus.store.fetch(job_id)
      cache[:total] = total
      JobStatus.store.write(job_id, cache)
    end

    #
    # Store data for the provided job_id
    #
    # @param job_id [String] ActiveJob job_id to attach information to in storage
    # @param store [Object] Data to be save within the storage, can be any serializable object
    #
    def store(job_id:, store:)
      cache = JobStatus.store.fetch(job_id)
      cache[:store] = store
      JobStatus.store.write(job_id, cache)
    end

    # Class Methods to be included
    module ClassMethods
    end
  end
end
