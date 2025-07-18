require "detect_language/version"
require "detect_language/errors"
require "detect_language/configuration"
require "detect_language/client"

module DetectLanguage
  class << self
    attr_writer :config

    def configure
      yield(config)
    end

    def config
      @config ||= Configuration.new
    end

    def client
      Thread.current[:detect_language_client] ||= Client.new(config)
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
      client.get('user/status')
    end

    def languages
      client.get('languages')
    end
  end
end
