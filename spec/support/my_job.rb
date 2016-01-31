class MyJob < ActiveJob::Base
  include JobStatus::TrackedJob

  queue_as :urgent

  def perform(*args)
    total(@job_id, 100)
    sleep(5)
    at(@job_id, 95)
    store(@job_id, [{test: 1, name: "test"},{test: 2, name: "test 2"}])
  end
end
