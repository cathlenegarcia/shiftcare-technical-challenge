# frozen_string_literal: true

require './spec/spec_helper'

RSpec.describe FindDuplicateEmailsCommand do
  subject(:execute) { described_class.new.execute }

  before do
    allow(File).to receive(:read).with('clients.json').and_return(clients.to_json)
  end

  describe '#execute' do
    context 'when there are duplicate emails' do
      let(:clients) do
        [
          { 'id' => 1, 'full_name' => 'John Doe', 'email' => 'jOhn@example.com' },
          { 'id' => 2, 'full_name' => 'Jane Smith', 'email' => 'jane@example.com' },
          { 'id' => 3, 'full_name' => 'John Smith', 'email' => 'john@example.com' },
          { 'id' => 4, 'full_name' => 'Jane Smith', 'email' => 'smith@example.com' },
          { 'id' => 5, 'full_name' => 'Jane Parish', 'email' => 'jane@example.com' },
        ]
      end

      it 'includes email and client details in output' do
        expected_output = <<~OUTPUT

          Found 2 email address(es) with multiple clients:

          Email: john@example.com
          - John Doe (ID: 1)
          - John Smith (ID: 3)

          Email: jane@example.com
          - Jane Smith (ID: 2)
          - Jane Parish (ID: 5)
        OUTPUT
        expect { execute }.to output(expected_output).to_stdout
      end
    end

    context 'when there are no duplicate emails' do
      let(:clients) do
        [
          { 'id' => 1, 'full_name' => 'John Doe', 'email' => 'john@example.com' },
          { 'id' => 2, 'full_name' => 'Jane Smith', 'email' => 'jane@example.com' }
        ]
      end

      it 'outputs no duplicates message when none found' do
        expect { execute }.to output(/No duplicate email addresses found./).to_stdout
      end
    end
  end
end
