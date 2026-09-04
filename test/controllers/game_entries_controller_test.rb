require "test_helper"

class GameEntriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get game_entries_index_url
    assert_response :success
  end
end
