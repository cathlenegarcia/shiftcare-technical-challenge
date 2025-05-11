# frozen_string_literal: true

require_relative '../services/client_searcher'

require 'json'

class SearchClientsCommand
  def initialize(query)
    @query = query
    @clients = JSON.parse(File.read('clients.json'))
    @searcher = ClientSearcher.new(@clients)
  end

  def execute
    matches = @searcher.call(@query)

    if matches.empty?
      puts "No clients found matching '#{@query}'"
    else
      puts "\nFound #{matches.length} matching client(s):"
      matches.each do |client|
        puts "- #{client['full_name']} (#{client['email']})"
      end
    end
  end
end
