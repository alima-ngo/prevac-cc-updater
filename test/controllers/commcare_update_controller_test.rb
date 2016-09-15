require 'test_helper'

class CommcareUpdateControllerTest < ActionDispatch::IntegrationTest
  test "should get step1" do
    get commcare_update_step1_url
    assert_response :success
  end

  test "should get step2" do
    get commcare_update_step2_url
    assert_response :success
  end

  test "should get step3" do
    get commcare_update_step3_url
    assert_response :success
  end

  test "should get step4" do
    get commcare_update_step4_url
    assert_response :success
  end

  test "should get step5" do
    get commcare_update_step5_url
    assert_response :success
  end

end
