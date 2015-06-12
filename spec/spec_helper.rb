# $: << File.expand_path(File.dirname(__FILE__)) + '/../'
# $: << File.expand_path(File.dirname(__FILE__) + "/../lib")
#
#
# require 'rspec'


Dir["./lib/*.rb"].each { |file| require file }


#######################

ENV['RAILS_ENV'] ||= 'test'

root = File.expand_path(File.join('..', '..', '..'), __FILE__)


require 'surrogate/rspec'
require 'rspec/core'
require 'webmock/rspec'


RSpec.configure do |config|

  spec_root = File.expand_path(File.join('..'), __FILE__)

  config.order = :random
  config.treat_symbols_as_metadata_keys_with_true_values = true


  unless ENV['INTEGRATION'] == 'true'
    config.filter_run_excluding :integration => true
  end
end

