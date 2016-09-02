require 'test_helper'

describe EasyAuth::Configuration do
  it "should be instantiated" do
    conf = EasyAuth::Configuration.new
    assert_equal Base64.urlsafe_encode64('elibinary:easy_auth:app_key'), conf.app_key
    assert_equal Base64.urlsafe_encode64('elibinary:easy_auth:secret_key'), conf.secret_key
  end

  it "should be configured" do
    # config in test_helper
    assert_equal Base64.urlsafe_encode64('elibinary:easy_auth:app_key'), EasyAuth.conf.app_key

    # reconfigure
    EasyAuth.configure do |conf|
      conf.app_key = 'test111'
      conf.secret_key = 'test111XXXxxx'
    end

    assert_equal 'test111', EasyAuth.conf.app_key
    assert_equal 'test111XXXxxx', EasyAuth.conf.secret_key
  end
end
