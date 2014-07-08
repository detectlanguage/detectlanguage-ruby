require "detect_language/version"
require "detect_language/errors"
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

    def detect(data)
      key = data.is_a?(Array) ? 'q[]' : 'q'
      result = client.post(:detect, key => data)
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

    def user_status
      client.post('user/status')
    end

    def languages
      client.get('languages')
    end
  end
end
