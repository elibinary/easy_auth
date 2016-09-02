module EasyAuth
  class Sign
    def self.generate_init_sign(encode_params)
      digest = OpenSSL::Digest.new('sha1')
      data = "#{EasyAuth.conf.app_key}#{encode_params}"
      OpenSSL::HMAC.digest(digest, EasyAuth.conf.secret_key, data)
    end
  end
end