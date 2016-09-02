module EasyAuth
  class Parameters
    def self.from_param(request)
      params = request.parameters
      params[:sign] ||= from_header(request)
      params
    end

    def self.from_header(request)
      request.headers['sign']
    end
  end
end