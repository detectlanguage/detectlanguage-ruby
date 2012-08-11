module DetectLanguage
  class Configuration
    # The API key for your project, found on your homepage after you login into detectlanguage.com website
    # Defaults to 'demo', which has a limited number of requests.
    attr_accessor :api_key

    # The API version you are using (defaults to 0.2).
    attr_accessor :api_version

    # HTTP request user agent (defaults to 'Detect Language API ruby gem').
    attr_accessor :user_agent

    # The host to connect to (defaults to ws.detectlanguage.com).
    attr_accessor :host

    # The port on which your DetectLanguage server runs (defaults to 443 for secure
    # connections, 80 for insecure connections).
    attr_accessor :port

    # +true+ for https connections, +false+ for http connections.
    attr_accessor :secure

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

    alias_method :secure?, :secure

    def initialize
      @api_key            = "demo"
      @api_version        = "0.2"
      @host               = "ws.detectlanguage.com"
      @user_agent         = "Detect Language API ruby gem"
    end

    def protocol
      if secure?
        'https'
      else
        'http'
      end
    end

    def port
      @port || default_port
    end

    # Allows config options to be read like a hash
    #
    # @param [Symbol] option Key for a given attribute
    def [](option)
      send(option)
    end

    private

    # Determines what port should we use for sending requests.
    # @return [Fixnum] Returns 443 if you've set secure to true in your
    # configuration, and 80 otherwise.
    def default_port
      if secure?
        443
      else
        80
      end
    end

  end
end