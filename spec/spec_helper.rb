# frozen_string_literal: true

require 'bundler/setup'
require 'json'

# Add lib directory to the load path
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

# Load all the files we need to test
require 'services/client_searcher'
require 'services/duplicate_email_finder'
require 'commands/search_clients_command'
require 'commands/find_duplicate_emails_command'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.filter_run_when_matching :focus
  config.disable_monkey_patching!
  config.warnings = true
  config.default_formatter = 'doc' if config.files_to_run.one?

  config.order = :random
  Kernel.srand config.seed
end
