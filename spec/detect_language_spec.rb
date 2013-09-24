# encoding: utf-8

require 'spec_helper'

describe DetectLanguage do

  context "configuration" do
    it "should have default configuration values" do
      subject.configuration.api_key.should      be_nil
      subject.configuration.api_version.should  == '0.2'
      subject.configuration.host.should         == 'ws.detectlanguage.com'
      subject.configuration.user_agent.should   == 'Detect Language API ruby gem'
    end

    it "should allow configuring" do
      subject.configure do |config|
        config.user_agent = "Detect Language testing"
      end

      subject.configuration.user_agent.should == "Detect Language testing"
    end
  end

  context "detection" do
    before do
      # testing key
      subject.configuration.api_key = "93dfb956a294140a4370a09584af2ef6"
    end

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
  end

  it "should raise exception for invalid key" do
    old_api_key = subject.configuration.api_key

    subject.configuration.api_key = "invalid"

    lambda {
      subject.detect("Hello world")
    }.should raise_error(::DetectLanguage::Exception)

    subject.configuration.api_key = old_api_key
  end

end