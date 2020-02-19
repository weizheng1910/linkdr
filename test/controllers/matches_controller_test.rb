require 'test_helper'

class MatchesControllerTest < ActionDispatch::IntegrationTest
  test "should get matches" do
    get matches_matches_url
    assert_response :success
  end

end
