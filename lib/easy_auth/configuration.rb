module EasyAuth
  class Configuration
    attr_accessor :app_key, :secret_key

    DEFAULT_APP_KEY = Base64.urlsafe_encode64('elibinary:easy_auth:app_key')
    DEFAULT_SECRET_KEY = Base64.urlsafe_encode64('elibinary:easy_auth:secret_key')
    
    def initialize
      @app_key = DEFAULT_APP_KEY
      @secret_key = DEFAULT_SECRET_KEY
    end
  end

  def self.conf
    @conf ||= Configuration.new
  end

  def self.configure
    yield(self.conf)
  end
end