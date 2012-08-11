require 'net/http'
require 'json'

module DetectLanguage
  class Client
    attr_reader :configuration

    def initialize(configuration)
      @configuration = configuration
    end

    def execute(method, params)
      http = setup_http_connection

      request_params = params.merge(:key => configuration.api_key)

      request = Net::HTTP::Post.new(request_uri(method))
      request.set_form_data(request_params)
      request.add_field('User-Agent', configuration.user_agent)

      response = http.request(request)

      case response
        when Net::HTTPSuccess then
          parse_response(response.body)
        else
          raise "Failure: #{response.class}"
      end
    end

    private

    def parse_response(response_body)
      response = JSON.parse(response_body)

      if response["error"].nil?
        response
      else
        raise Exception.new(response["error"]["message"])
      end
    end

    def request_uri(method)
      "/#{configuration.api_version}/#{method}"
    end

    def setup_http_connection
      http =
        Net::HTTP::Proxy(configuration.proxy_host, configuration.proxy_port, configuration.proxy_user,
                         configuration.proxy_pass).
          new(configuration.host, configuration.port)

      http.read_timeout = configuration.http_read_timeout
      http.open_timeout = configuration.http_open_timeout

      if configuration.secure?
        http.use_ssl      = true
        http.verify_mode  = OpenSSL::SSL::VERIFY_PEER
      else
        http.use_ssl      = false
      end

      http
    end
  end
end