# frozen_string_literal: true

require_relative '../services/duplicate_email_finder'

require 'json'

class FindDuplicateEmailsCommand
  def initialize
    @clients = JSON.parse(File.read('clients.json'))
    @duplicate_finder = DuplicateEmailFinder.new(@clients)
  end

  def execute
    duplicates = @duplicate_finder.call

    if duplicates.empty?
      puts 'No duplicate email addresses found.'
    else
      puts "\nFound #{duplicates.length} email address(es) with multiple clients:"
      duplicates.each do |email, clients|
        puts "\nEmail: #{email}"
        clients.each do |client|
          puts "- #{client['full_name']} (ID: #{client['id']})"
        end
      end
    end
  end
end
