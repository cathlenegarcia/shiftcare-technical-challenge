# frozen_string_literal: true

class ClientSearcher
  def initialize(clients)
    @clients = clients
  end

  def call(query)
    @clients.select do |client|
      client['full_name'].downcase.include?(query.downcase)
    end
  end
end
