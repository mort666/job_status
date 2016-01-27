# ActiveJob Status

Provides interface for ActiveJob to allow the passing of status information for running jobs.

This gem uses callbacks implemented within ActiveJob and ActiveSupport::Cache to values to track job status and allow the passing of job completion information.

Cached information is set to expire after 72 hours to prevent memory exhaustion issues.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'job_status'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install job_status

## Configuration

JobStatus needs to have a store configured to be used for the cache. Any ActiveSupport::Cache store is acceptable. The simplest to use is `ActiveSupport::Cache::MemoryStore`, to use the store configure an initializer within you application to set the store.

```ruby
# config/initializers/active_job_status.rb
JobStatus.store = ActiveSupport::Cache::MemoryStore.new
```

Other memory stores are available, for example it is possible to use the Redis based store or MemCache based store.

## Usage

Create ActiveJob worker as normal and add the callback handlers and class methods for reporting status.

```ruby
class MyJob < ActiveJob::Base
  include JobStatus::TrackedJob

  queue_as :urgent

  def perform(*args)
    # Set the total for a percentage
    total(job_id: @job_id, total: 100)

    # Do Stuff...
    # Set current status through
    at(job_id: @job_id, at: 95)

    # Store data to be retrieved
    store(job_id: @job_id, store: [{test: 1, name: "test"},{test: 2, name: "test 2"}])
  end
end
```

### Job Status

You can check the status of the job using the ActiveJob job_id.

```ruby
my_job = MyJob.perform_later
JobStatus::Status.get_status(job_id: my_job.job_id)
# => :queued, :working, :completed
```

More information can be found in the docs.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/job_status.
