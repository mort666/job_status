require "spec_helper"

describe JobStatus::Tracker do

  let!(:store) { JobStatus.store = ActiveSupport::Cache::MemoryStore.new }
  let(:job) { JobStatus::TrackedJob.new.enqueue }

  describe "::enqueue" do
    it "should enqueue a job" do
      JobStatus::Tracker.enqueue(job_id: job.job_id)
      expect(store.fetch(job.job_id)[:status]).to eq :queued
    end
  end

  describe "::update" do
    it "should update a job status" do
      JobStatus::Tracker.update(job_id: job.job_id, status: :working)
      expect(store.fetch(job.job_id)[:status]).to eq :working
    end
  end

  describe "::at" do
    it "should add an at to job status" do
      JobStatus::Tracker.at(job_id: job.job_id, at: 5)
      expect(store.fetch(job.job_id)[:at]).to eq 5
    end
  end

  describe "::remove" do
    it "should remove the job from the cache store" do
      JobStatus::Tracker.remove(job_id: job.job_id)
      expect(store.fetch(job.job_id)).to eq nil
    end
  end
end
