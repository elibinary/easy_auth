require 'test_helper'
require 'openssl'

describe EasyAuth::Oauth do
  before do
    @params = {
      deadline: (Time.now + 2.hours).to_i
    }

    @encode_params = Base64.urlsafe_encode64(@params.to_json)

    digest = OpenSSL::Digest.new('sha1')
    data = "#{EasyAuth.conf.app_key}#{@encode_params}"
    @init_sign = OpenSSL::HMAC.digest(digest, EasyAuth.conf.secret_key, data)
    @sign = "#{EasyAuth.conf.app_key}:#{Base64.urlsafe_encode64(@init_sign)}:#{@encode_params}"
    @oauth = EasyAuth::Oauth.new
  end

  it 'should be decode basic' do
    @oauth.decode_basic_sign(@sign)

    assert_equal Base64.urlsafe_encode64(@init_sign), @oauth.encode_sign
    assert_equal @encode_params, @oauth.encode_params
  end

  it 'should be decoded_sign' do
    @oauth.decode_basic_sign(@sign)
    assert_equal @init_sign, @oauth.decoded_sign
  end

  it 'should be params_body' do
    @oauth.decode_basic_sign(@sign)
    assert_equal @params, @oauth.params_body
  end

  it 'should verify_deadline?' do
    @oauth.decode_basic_sign(@sign)
    assert @oauth.verify_deadline?
  end

  it 'should verify_sign return nil' do
    assert @oauth.verify_sign(@sign).blank?
  end

  it 'should verify_sign return error' do
    sign = "#{EasyAuth.conf.app_key}:#{Base64.urlsafe_encode64('abc123')}:#{@encode_params}"
    res = @oauth.verify_sign(sign)
    p res.class
    assert res.is_a?(EasyAuth::Error)
    assert_equal 620, res.res_errors.first[:code]
  end
end
