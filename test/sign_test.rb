require 'test_helper'
require 'openssl'

describe EasyAuth::Sign do
  before do
    @params = {
      deadline: (Time.now + 2.hours).to_i
    }

    @encode_params = Base64.urlsafe_encode64(@params.to_json)
  end

  it 'should be decode basic' do
    digest = OpenSSL::Digest.new('sha1')
    data = "#{EasyAuth.conf.app_key}#{@encode_params}"
    init_sign = OpenSSL::HMAC.digest(digest, EasyAuth.conf.secret_key, data)

    assert_equal init_sign, EasyAuth::Sign.generate_init_sign(@encode_params)
  end
end
