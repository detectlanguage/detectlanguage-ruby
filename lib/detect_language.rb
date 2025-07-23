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

    def client=(client)
      Thread.current[:detect_language_client] = client
    end

    # @param query String
    # @return [Array<Hash>] Array of language detections
    def detect(query)
      if query.is_a?(Array)
        warn '[DEPRECATED] `DetectLanguage.detect` with an array of queries is deprecated. Use `DetectLanguage.detect_batch` instead.'
        return detect_batch(query)
      end

      client.post('detect', q: query)
    end

    # @param queries Array<String> Array of queries to detect languages for
    # @return [Array<Array<Hash>>] Array of language detections for each query
    def detect_batch(queries)
      raise(ArgumentError, 'Expected an Array of queries') unless queries.is_a?(Array)

      client.post('detect-batch', q: queries)
    end

    # @param text String
    # @return [String, nil] Detected language code or nil if no detection found
    def detect_code(text)
      detections = detect(text)

      return if detections.empty?

      detections[0]['language']
    end

    # @return [Hash] Account status information
    def account_status
      client.get('account/status')
    end

    # @return [Array<Hash>] List of supported languages
    def languages
      client.get('languages')
    end

    ### DEPRECATED METHODS

    # @deprecated Use `DetectLanguage.config` instead
    def configuration
      warn '[DEPRECATED] `DetectLanguage.configuration` is deprecated. Use `DetectLanguage.config` instead.'
      config
    end

    # @deprecated Use `detect_code` instead
    def simple_detect(text)
      warn '[DEPRECATED] `DetectLanguage.simple_detect` is deprecated. Use `DetectLanguage.detect_code` instead.'
      detect_code(text)
    end

    # @deprecated Use `DetectLanguage.account_status` instead
    def user_status
      warn '[DEPRECATED] `DetectLanguage.user_status` is deprecated. Use `DetectLanguage.account_status` instead.'
      account_status
    end
  end
end
