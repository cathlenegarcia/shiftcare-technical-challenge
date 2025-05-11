# frozen_string_literal: true

class DuplicateEmailFinder
  def initialize(clients)
    @clients = clients
  end

  def call
    email_groups = @clients.group_by { |client| client['email'].downcase }
    email_groups.select { |_, group| group.length > 1 }
  end
end
