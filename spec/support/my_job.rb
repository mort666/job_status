class MyJob < ActiveJob::Base
  include JobStatus::TrackedJob

  queue_as :urgent

  def perform(*args)
    total(job_id: @job_id, total: 100)
    sleep(5)
    at(job_id: @job_id, at: 95)
    store(job_id: @job_id, store: [{test: 1, name: "test"},{test: 2, name: "test 2"}])
  end
end
