module DetectLanguage
  class Configuration
    # The API key for your project, found on your homepage after you login into detectlanguage.com website
    attr_accessor :api_key

    # HTTP request user agent (defaults to 'Detect Language API ruby gem').
    attr_accessor :user_agent

    # API base URL
    attr_accessor :base_url

    # The HTTP open timeout in seconds.
    attr_accessor :http_open_timeout

    # The HTTP read timeout in seconds.
    attr_accessor :http_read_timeout

    # The hostname of your proxy server (if using a proxy).
    attr_accessor :proxy_host

    # The port of your proxy server (if using a proxy).
    attr_accessor :proxy_port

    # The username to use when logging into your proxy server (if using a proxy).
    attr_accessor :proxy_user

    # The password to use when logging into your proxy server (if using a proxy).
    attr_accessor :proxy_pass

    def initialize
      @api_key = nil
      @base_url = "https://ws.detectlanguage.com/v3/"
      @user_agent = "detectlanguage-ruby/#{VERSION}"
    end
  end
end
