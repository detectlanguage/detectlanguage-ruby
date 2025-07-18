require 'net/http'
require 'net/https'
require 'json'

module DetectLanguage
  class Client
    attr_reader :config

    def initialize(config)
      @config = config
    end

    def post(path, params = {})
      execute(Net::HTTP::Post, path, params)
    end

    def get(path, params = {})
      execute(Net::HTTP::Get, path, params)
    end

    private

    def execute(method, path, params)
      uri = URI.parse(config.base_url)
      http = setup_http_connection(uri)
      request = method.new(uri.path + path.to_s)
      request.set_form_data(params)

      request['Authorization'] = 'Bearer ' + config.api_key.to_s
      request['User-Agent'] = config.user_agent

      response = http.request(request)

      case response
      when Net::HTTPSuccess, Net::HTTPUnauthorized then
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

    def setup_http_connection(uri)
      http = Net::HTTP::Proxy(
        config.proxy_host, config.proxy_port, config.proxy_user, config.proxy_pass
      ).new(uri.host, uri.port)

      http.read_timeout = config.http_read_timeout
      http.open_timeout = config.http_open_timeout

      if uri.scheme == 'https'
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_PEER
      else
        http.use_ssl = false
      end

      http
    end
  end
end
