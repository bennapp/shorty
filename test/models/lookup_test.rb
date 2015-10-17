require 'rails_helper'

RSpec.describe Lookup, :type => :model do
  let(:lookup) { lookups(:lookie) }

  describe 'validations' do
    before do
      lookup.should be_valid
    end

    it 'requires presence of url' do
      lookup.url = nil
      lookup.should_not be_valid
    end

    it 'requires presence of token' do
      lookup.token = nil
      lookup.should_not be_valid
    end
  end
end
