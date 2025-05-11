# frozen_string_literal: true

require './spec/spec_helper'

RSpec.describe ClientSearcher do
  subject(:call) { described_class.new(clients).call(query_string) }

  let(:results) { call }
  let(:clients) do
    [
      { 'id' => 1, 'full_name' => 'John Doe', 'email' => 'john@example.com' },
      { 'id' => 2, 'full_name' => 'Jane Smith', 'email' => 'jane@example.com' },
      { 'id' => 3, 'full_name' => 'John Smith', 'email' => 'john.smith@example.com' }
    ]
  end

  let(:searcher) { described_class.new(clients) }

  describe '#call' do
    context 'when query string matches client names' do
      let(:query_string) { 'jOhn' }

      it 'returns clients with matching names' do
        expect(results.length).to eq(2)
        expect(results.map { |c| c['full_name'] }).to contain_exactly('John Doe', 'John Smith')
      end
    end

    context 'when query string does not match any client name' do
      let(:query_string) { 'xyz' }

      it 'returns clients with matching names' do
        expect(results).to be_empty
      end
    end

    context 'when partial matching is used' do
      let(:query_string) { 'smith' }

      it 'returns partial matches' do
        expect(results.length).to eq(2)
        expect(results.map { |c| c['full_name'] }).to contain_exactly('Jane Smith', 'John Smith')
      end
    end
  end
end
