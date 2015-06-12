#!/usr/bin/env rake

begin

  require 'rspec/core/rake_task'

  task :default => [
           #:set_run_integration_specs,
           :spec,
       # :js_spec,
       #:find_trailing_whitespace
       ]

  task :js_spec do
    ENV['NO_LOG'] = 'true'
    sh "RAILS_ENV=development bundle exec teaspoon"
  end

  desc 'Run all specs'
  task :spec do
    RSpec::Core::RakeTask.new { |t| t.verbose = false }
    # RSpec::Core::RakeTask.new(:spec) do |task|
    #   task.rspec_opts = '--format documentation'
    # end
  end

  desc "Set Integration tests to run"
  task :set_run_integration_specs do
    ENV['INTEGRATION'] = 'true'
  end

  rescue LoadError => e
  end

  desc 'Run each spec individually. This helps to discover missing requires.'
  task :individual_specs do
    Dir['spec/**/*_spec.rb'].each do |spec|
      sh "bundle exec rspec #{spec}"
    end
  end

  desc "Finds trailing whitespace in Ruby files"
  task :find_trailing_whitespace do
    Dir[Rails.root.join('**/*.rb')].each do |file_name|
      text = File.open(file_name, 'r'){ |file| file.read }
      fail "Found trailing whitespace in #{file_name}" if text =~ / +$/
    end
  end

  desc 'Generate a migration timestamp'
  task :migration_number do
    puts Time.now.utc.strftime("%Y%m%d%H%M%S")
  end

  desc 'Open a console with the application loaded'
  task :console do
    require 'irb'
    ARGV.clear
    puts "Loaded #{Rails.env} environment"
    IRB.start
  end

