require "test_helper"

class Piblic::AddressesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get piblic_addresses_index_url
    assert_response :success
  end

  test "should get edit" do
    get piblic_addresses_edit_url
    assert_response :success
  end
end
