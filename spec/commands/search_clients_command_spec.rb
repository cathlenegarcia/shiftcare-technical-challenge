# frozen_string_literal: true

require './spec/spec_helper'

RSpec.describe SearchClientsCommand do
  subject(:execute) { described_class.new(query_string).execute }
  let(:clients_data) do
    [
      { 'id' => 1, 'full_name' => 'John Doe', 'email' => 'john@example.com' },
      { 'id' => 2, 'full_name' => 'Jane Smith', 'email' => 'jane@example.com' },
      { 'id' => 3, 'full_name' => 'JoHn Smith', 'email' => 'smith@example.com' },
    ]
  end

  before do
    allow(File).to receive(:read).with('clients.json').and_return(clients_data.to_json)
  end

  describe '#execute' do
    context 'when query string matches clients' do
      let(:query_string) { 'john' }

      it 'outputs matching clients' do
        expected_output = <<~OUTPUT

          Found 2 matching client(s):
          - John Doe (john@example.com)
          - JoHn Smith (smith@example.com)
        OUTPUT
        expect { execute }.to output(expected_output).to_stdout
      end
    end

    context 'when query string does not match any client' do
      let(:query_string) { 'xyz' }

      it 'outputs no matches message when no results found' do
        expect { execute }.to output(/No clients found matching 'xyz'/).to_stdout
      end
    end
  end
end
