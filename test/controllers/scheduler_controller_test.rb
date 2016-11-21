require 'test_helper'

class SchedulerControllerTest < ActionDispatch::IntegrationTest
  test "should get schedule" do
    get scheduler_schedule_url
    assert_response :success
  end

end
