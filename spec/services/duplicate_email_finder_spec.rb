# frozen_string_literal: true

require './spec/spec_helper'

RSpec.describe DuplicateEmailFinder do
  subject(:call) { described_class.new(clients).call }

  let(:results) { call }

  describe '#call' do
    context 'when there are duplicates' do
      let(:clients) do
        [
          { 'id' => 1, 'full_name' => 'John Doe', 'email' => 'jOhn@example.com' },
          { 'id' => 2, 'full_name' => 'Jane Smith', 'email' => 'jane@example.com' },
          { 'id' => 3, 'full_name' => 'John Smith', 'email' => 'john@example.com' },
          { 'id' => 4, 'full_name' => 'Alice Brown', 'email' => 'alice@example.com' }
        ]
      end

      it 'returns hash with duplicate emails as keys' do
        expect(results.keys).to contain_exactly('john@example.com')
      end

      it 'groups clients by duplicate email' do
        expect(results['john@example.com'].length).to eq(2)
        expect(results['john@example.com'].map { |c| c['full_name'] })
          .to contain_exactly('John Doe', 'John Smith')
      end
    end

    context 'when there are no duplicates' do
      let(:clients) do
        [
          { 'id' => 1, 'full_name' => 'John Doe', 'email' => 'john@example.com' },
          { 'id' => 2, 'full_name' => 'Jane Smith', 'email' => 'jane@example.com' }
        ]
      end

      it 'returns empty hash' do
        expect(results).to be_empty
      end
    end
  end
end
