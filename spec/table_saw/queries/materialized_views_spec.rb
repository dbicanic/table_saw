# frozen_string_literal: true

RSpec.describe TableSaw::Queries::MaterializedViews do
  subject(:query) { described_class.new }

  it 'returns list of all materialized views' do
    expect(query.call).to eq %w(popular_authors)
  end
end
