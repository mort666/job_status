module JobStatus
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)
      desc "Creates JobStatus initializer"

      def copy_initializer
        template "job_status_initializer.rb", "config/initializers/job_status.rb"
      end
    end
  end
end
