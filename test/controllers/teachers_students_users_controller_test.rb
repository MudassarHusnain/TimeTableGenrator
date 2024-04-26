require "test_helper"

class TeachersStudentsUsersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get teachers_students_users_index_url
    assert_response :success
  end
end
