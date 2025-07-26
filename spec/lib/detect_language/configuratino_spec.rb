# frozen_string_literal: true

RSpec.describe DetectLanguage::Configuration do
  describe '#api_key' do
    it 'returns the api key' do
      expect(subject.api_key).to be_nil
    end
  end

  describe '#base_url' do
    it 'returns the base url' do
      expect(subject.base_url).to eq('https://ws.detectlanguage.com/v3/')
    end
  end

  describe '#user_agent' do
    it 'returns the user agent' do
      expect(subject.user_agent).to eq("detectlanguage-ruby/#{DetectLanguage::VERSION}")
    end
  end
end
