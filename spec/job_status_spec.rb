require "spec_helper"

describe JobStatus::Status do

  describe "::get_status" do
    describe "for a queued job" do
      let(:job) { MyJob.new.enqueue }

      it "should return :queued" do
        expect(JobStatus::Status.get_status(job_id: job.job_id)).to eq :queued
      end
    end

    describe "for a complete job" do
      let(:job) { MyJob.perform_later(job: 1) }

      it "should return :completed" do
        perform_enqueued_jobs { job }
          expect(JobStatus::Status.get_status(job_id: job.job_id)).to eq :completed
      end
    end

    describe "::get_all" do
      let(:job) { MyJob.perform_later(job: 2) }

      it "should return :completed" do
        perform_enqueued_jobs { job }
        expect(JobStatus::Status.get_all(job_id: job.job_id)[:total]).to eq 100
      end
    end

    describe "::store" do
      let(:job) { MyJob.perform_later(job: 3) }

      it "should return Hash" do
        perform_enqueued_jobs { job }
        expect(JobStatus::Status.store(job_id: job.job_id)).to include({:test=>1, :name=>"test"})
      end
    end

    describe "::at" do
      let(:job) { MyJob.perform_later(job: 4) }

      it "should return :completed" do
        perform_enqueued_jobs { job }
        expect(JobStatus::Status.at(job_id: job.job_id)).to eq 95
      end
    end

    describe "::total" do
      let(:job) { MyJob.perform_later(job: 5) }

      it "should return :100" do
        perform_enqueued_jobs { job }
        expect(JobStatus::Status.total(job_id: job.job_id)).to eq 100
      end
    end
  end

  after do
    clear_enqueued_jobs
    clear_performed_jobs
  end
end
