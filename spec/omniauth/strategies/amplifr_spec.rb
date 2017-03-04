require 'spec_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe OmniAuth::Strategies::Amplifr do
  let(:request) { double('Request', params: {}, cookies: {}, env: {}) }

  let(:app) { -> { [200, {}, ["Hello, Amplifr!"]] } }

  subject do
    described_class.new(app, 'appid', 'secret', @options || {}).tap do |amplifr|
      allow(amplifr).to receive(:request) { request }
    end
  end

  before { OmniAuth.config.test_mode = true  }
  after  { OmniAuth.config.test_mode = false }

  describe '#client_options' do
    it 'has correct site' do
      expect(subject.client.site).to eq('https://amplifr.com')
    end

    it 'has correct authorize_url' do
      expect(subject.client.options[:authorize_url]).to eq('/oauth/authorize')
    end

    it 'has correct token_url' do
      expect(subject.client.options[:token_url]).to eq('/oauth/token')
    end

    describe "overrides" do
      it 'should allow overriding the site' do
        @options = { client_options:  { 'site' => 'https://example.com' } }
        expect(subject.client.site).to eq('https://example.com')
      end

      it 'should allow overriding the authorize_url' do
        @options = { client_options: { 'authorize_url' => '/authorize' } }
        expect(subject.client.options[:authorize_url]).to eq('/authorize')
      end

      it 'should allow overriding the token_url' do
        @options = { client_options: { 'token_url' => '/oauth2_token' } }
        expect(subject.client.options[:token_url]).to eq('/oauth2_token')
      end
    end
  end
end
