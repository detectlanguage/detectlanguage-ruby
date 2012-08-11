require "detect_language/version"
require "detect_language/exception"
require "detect_language/configuration"
require "detect_language/client"

module DetectLanguage
  class << self
    attr_writer :configuration

    def configure
      yield(configuration)
    end

    # The configuration object.
    # @see DetectLanguage.configure
    def configuration
      @configuration ||= Configuration.new
    end

    def client
      @client ||= Client.new(configuration)
    end

    def detect(text)
      result = client.execute(:detect, :q => text)
      result['data']['detections']
    end

    def simple_detect(text)
      detections = detect(text)

      if detections.empty?
        nil
      else
        detections[0]['language']
      end
    end
  end
end
