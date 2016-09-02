module EasyAuth
  class Error
    AUTHENTICATE_PARAMETERS_FAILD = 'authenticate parameters failed'
    INVALID_TOKEN = 'invalid token'
    INVALID_CREDENTIAL = 'invalid credential'
    AUTHENTICATE_PARAMETERS_EXPIRED = 'authenticate parameters expired'


    ERROR_CODE = {
      AUTHENTICATE_PARAMETERS_FAILD => 600,
      INVALID_TOKEN => 610,
      INVALID_CREDENTIAL => 620,
      AUTHENTICATE_PARAMETERS_EXPIRED => 630
    }
    # def body
    #   {
    #     error: ,
    #     error_description: ,
    #     code: 
    #   }
    # end

    def self.oh_error(*args)
      new.add_error(*args)
    end

    def res_errors
      @res_errors ||= []
    end

    def add_error(error, code = nil, desc=nil)
      if code.blank?
        res_errors << { 
          code: ERROR_CODE[error], 
          error: error, 
          error_description: desc 
        }.reject { |_, v| v.blank? }
      else
        res_errors << { 
          code: code, 
          error: code, 
          error_description: desc 
        }.reject { |_, v| v.blank? }
      end
    end

    def render_error(status = 200)
      render json: { errors: res_errors }, status: status
    end
  end
end