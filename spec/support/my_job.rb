class MyJob < JobStatus::TrackedJob
  queue_as :urgent

  def perform(*args)
    JobStatus::Tracker.total(job_id: @job_id, total: 100)
    sleep(5)
    JobStatus::Tracker.at(job_id: @job_id, at: 95)
    JobStatus::Tracker.store(job_id: @job_id, store: [{test: 1, name: "test"},{test: 2, name: "test 2"}])
  end
end
