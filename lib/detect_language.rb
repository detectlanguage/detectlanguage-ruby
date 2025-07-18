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

    def detect(query)
      client.post('detect', q: query)
    end

    def detect_batch(queries)
      raise(ArgumentError, 'Expected an Array of queries') unless queries.is_a?(Array)

      client.post('detect-batch', 'q[]': queries)
    end

    def detect_code(text)
      detections = detect(text)

      return if detections.empty?

      detections[0]['language']
    end

    def account_status
      client.get('account/status')
    end

    def languages
      client.get('languages')
    end
  end
end
