require 'net/http'
require 'net/https'
require 'json'

module DetectLanguage
  class Client
    attr_reader :config

    def initialize(config)
      @config = config
    end

    def post(path, payload = {})
      execute(Net::HTTP::Post, path, body: payload.to_json)
    end

    def get(path)
      execute(Net::HTTP::Get, path)
    end

    private

    def execute(method, path, body: nil)
      request = method.new(base_uri.path + path)
      request.body = body

      request['Content-Type'] = 'application/json'
      request['Authorization'] = 'Bearer ' + config.api_key.to_s
      request['User-Agent'] = config.user_agent

      response = connection.request(request)

      case response
      when Net::HTTPSuccess, Net::HTTPUnauthorized
        parse_response(response.body)
      else
        raise(Error, "Failure: #{response.class}")
      end
    end

    def parse_response(response_body)
      response = JSON.parse(response_body)

      if response.is_a?(Array) || response["error"].nil?
        response
      else
        raise(Error, response["error"]["message"])
      end
    end

    def base_uri
      @base_uri ||= URI(config.base_url)
    end

    def connection
      @connection ||= setup_connection
    end

    def setup_connection
      http = if config.proxy
        proxy = URI(config.proxy)
        Net::HTTP.new(base_uri.hostname, base_uri.port, proxy.hostname, proxy.port, proxy.user, proxy.password)
      else
        Net::HTTP.new(base_uri.hostname, base_uri.port)
      end

      http.use_ssl = base_uri.scheme == 'https'
      http.verify_mode = OpenSSL::SSL::VERIFY_PEER if http.use_ssl?
      http.read_timeout = config.http_read_timeout
      http.open_timeout = config.http_open_timeout

      http
    end
  end
end
