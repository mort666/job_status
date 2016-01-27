module JobStatus
  #
  # Status Module, retrieve the status information from the store
  #
  module Status
    #
    # Get the Status from the store
    #
    # @param job_id [String] ActiveJob ID to query the store for
    # @return [Symbol] status Returns status possible valuds
    #   :queued, :working, :completed
    #
    def self.get_status(job_id:)
      status = JobStatus.store.fetch(job_id)
      status ? status[:status] : nil
    end

    #
    # Get the current progress from the store
    #
    # @param job_id [String] ActiveJob ID to query the store for
    # @return [Integer] at Value stored by the work for the progress
    #
    def self.at(job_id:)
      status = JobStatus.store.fetch(job_id)
      status ? status[:at] : nil
    end

    #
    # Get the stored data from the store
    #
    # @param job_id [String] ActiveJob ID to query the store for
    # @return returns the stored data, could be any serializable object
    #
    def self.store(job_id:)
      status = JobStatus.store.fetch(job_id)
      status ? status[:store] : nil
    end

    #
    # Get the Total from the store
    #
    # @param job_id [String] ActiveJob ID to query the store for
    # @return [Integer] total Returns total used for the percentage
    #
    def self.total(job_id:)
      status = JobStatus.store.fetch(job_id)
      status ? status[:total] : nil
    end

    #
    # Get the All Data from the store
    #
    # @param job_id [String] ActiveJob ID to query the store for
    # @return returns all information held in the store for the job_id
    #
    def self.get_all(job_id:)
      status = JobStatus.store.fetch(job_id)
      status ? status : nil
    end
  end
end
