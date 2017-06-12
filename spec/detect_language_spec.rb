# encoding: utf-8

require 'spec_helper'

describe DetectLanguage do

  let(:api_key) { ENV['DETECTLANGUAGE_API_KEY'] }

  before do
    DetectLanguage.configuration.api_key = api_key
  end

  context "configuration" do
    it "should have default configuration values" do
      subject.configuration.api_version.should == '0.2'
      subject.configuration.host.should == 'ws.detectlanguage.com'
      subject.configuration.user_agent.should == 'Detect Language API ruby gem'
    end

    it "should allow configuring" do
      subject.configure do |config|
        config.user_agent = "Detect Language testing"
      end

      subject.configuration.user_agent.should == "Detect Language testing"
    end
  end

  context 'invalid api key' do
    let(:api_key) {'invalid'}

    it "should raise exception for invalid key" do
      lambda {
        subject.detect("Hello world")
      }.should raise_error(DetectLanguage::Error)
    end
  end

  context "detection" do
    it "should detect languages" do
      result = subject.detect("Hello world")
      result[0]['language'].should == "en"

      result = subject.detect("Jau saulelė vėl atkopdama budino svietą")
      result[0]['language'].should == "lt"
    end

    it "should have simple way to detect a language" do
      subject.simple_detect("Hello world").should == "en"
    end

    it "should allow sending batch requests" do
      result = subject.detect(["Hello world", "Jau saulelė vėl atkopdama budino svietą"])

      result[0][0]['language'].should == "en"
      result[1][0]['language'].should == "lt"
    end

    it "with empty text in the batch it detects correctly" do
      result = subject.detect(["", "Hello", "Jau saulelė vėl atkopdama budino svietą"])

      result[0].should be_empty
      result[1][0]['language'].should == "en"
      result[2][0]['language'].should == "lt"
    end

    context 'secure mode' do
      before { DetectLanguage.configuration.secure = true }
      after { DetectLanguage.configuration.secure = false }

      it "detects language" do
        result = subject.detect("Hello world")
        result[0]['language'].should == "en"
      end
    end
  end

  describe '.user_status' do
    subject(:user_status) {DetectLanguage.user_status}

    it 'fetches user status' do
      expect(user_status['date']).to be_kind_of(String)
      expect(user_status['requests']).to be_kind_of(Integer)
      expect(user_status['bytes']).to be_kind_of(Integer)
      expect(user_status['plan']).to be_kind_of(String)
      expect(user_status['daily_requests_limit']).to be_kind_of(Integer)
      expect(user_status['daily_bytes_limit']).to be_kind_of(Integer)
    end
  end

  describe '.languages' do
    subject(:languages) {DetectLanguage.languages}

    it 'fetches list of detectable languages' do
      expect(languages).to include({ 'code' => 'en', 'name' => 'ENGLISH' })
    end
  end
end
