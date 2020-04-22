require 'test_helper'

class StocksControllerTest < ActionDispatch::IntegrationTest
  test "should get stock" do
    get stocks_stock_url
    assert_response :success
  end

end
