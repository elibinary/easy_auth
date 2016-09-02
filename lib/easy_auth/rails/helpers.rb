module EasyAuth
  module Rails
    module Helpers
      extend ActiveSupport::Concern

      def easy_auth_sign!
        res = Oauth.new.verify_sign(complete_sign)
        if res && res.is_a?(EasyAuth::Error)
          res.render_error(401) and return
        end
      end

      def valid_doorkeeper_token?
        res = Oauth.new.verify_sign(complete_sign)
      end

      private

      def complete_sign
        con_params[:sign]
      end

      def con_params
        @con_params ||= Parameters.from_param(request)
      end
    end
  end
end