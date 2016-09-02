
module EasyAuth
  class Oauth
    attr_reader :app_key, :encode_sign, :encode_params, :params_body

    def decode_basic_sign(sign)
      params_array = sign.split(':')
      return Error.oh_error(AUTHENTICATE_PARAMETERS_FAILD) unless params_array.length == 3
      @app_key, @encode_sign, @encode_params = params_array
    end

    def decoded_sign
      Base64.urlsafe_decode64(@encode_sign)
    end

    def params_body
      @params_body ||= MultiJson.load(Base64.urlsafe_decode64(@encode_params)).symbolize_keys
    end

    def verify_deadline?
      params_body[:deadline] && params_body[:deadline] > Time.now.to_i
    end

    def verify_sign(sign)
      decode_basic_sign(sign)

      unless verify_deadline?
        return Error.oh_error(AUTHENTICATE_PARAMETERS_EXPIRED)
      end

      unless Sign.generate_init_sign(@encode_params) == decoded_sign
        Error.oh_error(INVALID_CREDENTIAL)
      end
    end
  end
end