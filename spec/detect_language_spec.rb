# frozen_string_literal: true

RSpec.describe DetectLanguage do
  let(:api_key) { ENV['DETECTLANGUAGE_API_KEY'] }
  let(:secure) { true }

  before do
    described_class.configuration.api_key = api_key
    described_class.configuration.secure = secure
  end

  describe '.configuration' do
    subject { described_class.configuration }

    it 'has default configuration values' do
      expect(subject.api_version).to eq('0.2')
      expect(subject.host).to eq('ws.detectlanguage.com')
      expect(subject.user_agent).to eq("detectlanguage-ruby/#{DetectLanguage::VERSION}")
    end
  end

  describe '.detect' do
    subject { described_class.detect(query) }

    let(:query) { 'Hello world' }

    it 'detects language' do
      expect(subject).to be_an(Array)
      expect(subject.first).to be_a(Hash)
      expect(subject.first['language']).to eq('en')
    end

    context 'with unicode characters' do
      let(:query) { 'Jau saulelė vėl atkopdama budino svietą' }

      it 'detects language with unicode characters' do
        expect(subject.first['language']).to eq('lt')
      end
    end

    context 'with batch requests' do
      let(:query) { ['', 'Hello world', 'Jau saulelė vėl atkopdama budino svietą'] }

      it 'detects languages in batch' do
        expect(subject).to be_an(Array)
        expect(subject.size).to eq(3)
        expect(subject[0]).to be_empty
        expect(subject[1][0]['language']).to eq('en')
        expect(subject[2][0]['language']).to eq('lt')
      end
    end

    context 'invalid api key' do
      let(:api_key) { 'invalid' }

      it "should raise exception for invalid key" do
        expect { subject }.to raise_error(DetectLanguage::Error)
      end
    end
  end

  describe '.simple_detect' do
    subject { described_class.simple_detect(query) }

    let(:query) { 'Hello world' }

    it 'detects language' do
      expect(subject).to eq('en')
    end
  end

  describe '.user_status' do
    subject { DetectLanguage.user_status }

    it 'fetches user status' do
      expect(subject).to include(
        'date' => kind_of(String),
        'requests' => kind_of(Integer),
        'bytes' => kind_of(Integer),
        'plan' => kind_of(String),
        'daily_requests_limit' => kind_of(Integer),
        'daily_bytes_limit' => kind_of(Integer),
      )
    end
  end

  describe '.languages' do
    subject { DetectLanguage.languages }

    it 'fetches list of detectable languages' do
      expect(subject).to include('code' => 'en', 'name' => 'ENGLISH')
    end

    context 'with http' do
      let(:secure) { false }

      it 'fetches languages over http' do
        expect(subject).to include('code' => 'en', 'name' => 'ENGLISH')
      end
    end
  end
end
