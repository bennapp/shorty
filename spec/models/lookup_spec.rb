require 'rails_helper'
require 'spec_helper'

RSpec.describe Lookup, :type => :model do
  let(:lookup) { lookups(:lookup) }

  describe 'validations' do
    before do
      expect(lookup.valid?).to be_truthy
    end

    it 'requires presence of url' do
      lookup.url = nil
      expect(lookup.valid?).to be_falsey
    end

    it 'requires unique tokens' do
      other_lookup = Lookup.new(url: 'test', token: lookup.token)
      expect(other_lookup.valid?).to be_falsey
    end
  end

  describe 'url' do
    context 'url has http protocol' do
      it 'does not prepend the url with http' do
        lookup = Lookup.create!(url: 'http://www.google.com', token: 'foo')
        expect(lookup.url == 'http://www.google.com').to be_truthy
      end
    end

    context 'url has https protocol' do
      it 'does not prepend the url with http' do
        lookup = Lookup.create!(url: 'https://www.google.com', token: 'foo')
        expect(lookup.url == 'https://www.google.com').to be_truthy
      end
    end

    context 'url does not have protocol' do
      it 'prepends the url with http' do
        lookup = Lookup.create!(url: 'www.google.com', token: 'foo')
        expect(lookup.url == 'http://www.google.com').to be_truthy
      end
    end
  end

  describe 'token' do
    context 'present' do
      it 'sets input' do
        token_before = lookup.token
        lookup.save!
        expect(lookup.reload.token).to eq(token_before)
      end
    end

    context 'not present' do
      context 'next id is not taken' do
        it 'sets base_36 encoded random int' do
          lookup.token = nil
          lookup.save!
          lookup.reload.token.size.should be < 9
        end
      end

      context 'next id is taken' do
        before do
          Lookup.create!(token: Lookup.maximum(:id).next.to_s(36), url: 'www.dgaf.net')
        end

        it 'sets base_36 encoded random int' do
          lookup.token = nil
          lookup.save!
          lookup.reload.token.size.should be < 9
        end
      end
    end
  end
end
