require 'test_helper'

class BarkParsesControllerTest < ActionController::TestCase
  setup do
    @bark_parse = bark_parses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bark_parses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bark_parse" do
    assert_difference('BarkParse.count') do
      post :create, bark_parse: { bark_id: @bark_parse.bark_id, x_choice: @bark_parse.x_choice, x_clause: @bark_parse.x_clause, x_hyper0: @bark_parse.x_hyper0, x_hyper1: @bark_parse.x_hyper1, x_hyper2plus: @bark_parse.x_hyper2plus, x_loc_hyper0: @bark_parse.x_loc_hyper0, x_loc_hyper1: @bark_parse.x_loc_hyper1, x_loc_hyper2plus: @bark_parse.x_loc_hyper2plus, x_pp: @bark_parse.x_pp, y_category: @bark_parse.y_category, y_clause: @bark_parse.y_clause, y_hyper0: @bark_parse.y_hyper0, y_hyper1: @bark_parse.y_hyper1, y_hyper2plus: @bark_parse.y_hyper2plus, y_loc_hyper0: @bark_parse.y_loc_hyper0, y_loc_hyper1: @bark_parse.y_loc_hyper1, y_loc_hyper2plus: @bark_parse.y_loc_hyper2plus, y_pp: @bark_parse.y_pp, z_reason: @bark_parse.z_reason }
    end

    assert_redirected_to bark_parse_path(assigns(:bark_parse))
  end

  test "should show bark_parse" do
    get :show, id: @bark_parse
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bark_parse
    assert_response :success
  end

  test "should update bark_parse" do
    put :update, id: @bark_parse, bark_parse: { bark_id: @bark_parse.bark_id, x_choice: @bark_parse.x_choice, x_clause: @bark_parse.x_clause, x_hyper0: @bark_parse.x_hyper0, x_hyper1: @bark_parse.x_hyper1, x_hyper2plus: @bark_parse.x_hyper2plus, x_loc_hyper0: @bark_parse.x_loc_hyper0, x_loc_hyper1: @bark_parse.x_loc_hyper1, x_loc_hyper2plus: @bark_parse.x_loc_hyper2plus, x_pp: @bark_parse.x_pp, y_category: @bark_parse.y_category, y_clause: @bark_parse.y_clause, y_hyper0: @bark_parse.y_hyper0, y_hyper1: @bark_parse.y_hyper1, y_hyper2plus: @bark_parse.y_hyper2plus, y_loc_hyper0: @bark_parse.y_loc_hyper0, y_loc_hyper1: @bark_parse.y_loc_hyper1, y_loc_hyper2plus: @bark_parse.y_loc_hyper2plus, y_pp: @bark_parse.y_pp, z_reason: @bark_parse.z_reason }
    assert_redirected_to bark_parse_path(assigns(:bark_parse))
  end

  test "should destroy bark_parse" do
    assert_difference('BarkParse.count', -1) do
      delete :destroy, id: @bark_parse
    end

    assert_redirected_to bark_parses_path
  end
end
