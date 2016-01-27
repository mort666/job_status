module JobStatus
  module Status
    def self.get_status(job_id:)
      status = JobStatus.store.fetch(job_id)
      status ? status[:status] : nil
    end

    def self.get_all(job_id:)
      status = JobStatus.store.fetch(job_id)
      status ? status : nil
    end
  end
end
