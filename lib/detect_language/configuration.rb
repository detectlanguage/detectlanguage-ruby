module DetectLanguage
  class Configuration
    # The API key for your project, found on your homepage after you log in into
    # https://detectlanguage.com website
    attr_accessor :api_key

    # API base URL
    attr_accessor :base_url

    # HTTP request user agent (defaults to 'Detect Language API ruby gem').
    attr_accessor :user_agent

    # The HTTP open timeout in seconds.
    attr_accessor :http_open_timeout

    # The HTTP read timeout in seconds.
    attr_accessor :http_read_timeout

    # The HTTP proxy to use for requests. Example: 'http://my-proxy:8080'
    attr_accessor :proxy

    def initialize
      @api_key = nil
      @base_url = "https://ws.detectlanguage.com/v3/"
      @user_agent = "detectlanguage-ruby/#{VERSION}"
    end
  end
end
