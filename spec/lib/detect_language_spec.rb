# frozen_string_literal: true

RSpec.describe DetectLanguage do
  let(:api_key) { ENV['DETECTLANGUAGE_API_KEY'] }
  let(:proxy) { nil }

  before do
    described_class.client = nil
    described_class.config.api_key = api_key
    described_class.config.proxy = proxy
  end

  describe '.config' do
    subject { described_class.config }

    it { is_expected.to be_a(DetectLanguage::Configuration) }
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

    context 'invalid api key' do
      let(:api_key) { 'invalid' }

      it "should raise exception for invalid key" do
        expect { subject }.to raise_error(DetectLanguage::Error)
      end
    end

    context 'with proxy' do
      let(:proxy) { 'http://dummy:pass@my-proxy:8080' }

      it 'uses the proxy for requests' do
        allow(Net::HTTP).to receive(:new)
          .with('ws.detectlanguage.com', 443, 'my-proxy', 8080, 'dummy', 'pass')
          .and_call_original

        expect { subject }.to raise_error(SocketError)
      end
    end
  end

  describe '.detect_code' do
    subject { described_class.detect_code(query) }

    let(:query) { 'Hello world' }

    it 'detects language' do
      expect(subject).to eq('en')
    end

    context 'with empty query' do
      let(:query) { ' ' }

      it 'returns nil for empty query' do
        expect(subject).to be_nil
      end
    end
  end

  describe '.detect_batch' do
    subject { described_class.detect_batch(queries) }

    let(:queries) { ['', 'Hello world', 'Jau saulelė vėl atkopdama budino svietą'] }

    it 'detects languages in batch' do
      expect(subject).to be_an(Array)
      expect(subject.size).to eq(3)
      expect(subject[0]).to be_empty
      expect(subject[1][0]['language']).to eq('en')
      expect(subject[2][0]['language']).to eq('lt')
    end

    context 'when queries is not an array' do
      let(:queries) { 'Hello world' }

      it 'raises an ArgumentError' do
        expect { subject }.to raise_error(ArgumentError, "Expected an Array of queries")
      end
    end
  end

  describe '.account_status' do
    subject { described_class.account_status }

    it 'fetches account status' do
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
      expect(subject).to include('code' => 'en', 'name' => 'English')
    end
  end
end
