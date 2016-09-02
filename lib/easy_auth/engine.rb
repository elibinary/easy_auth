require "rails"
module EasyAuth
  class Engine < Rails::Engine
    # initializer "easy_auth.params.filter" do |app|
    #   parameters = %w(client_secret code authentication_token access_token refresh_token)
    #   app.config.filter_parameters << /^(#{Regexp.union parameters})$/
    # end

    initializer "easy_auth.helpers" do
      ActiveSupport.on_load(:action_controller) do
        include EasyAuth::Rails::Helpers
      end
    end
  end
end
