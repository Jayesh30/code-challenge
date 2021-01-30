require "test_helper"

class CompanyTest < ActiveSupport::TestCase
  setup do
    @company = companies(:hometown_painting)
    @company_presenter = CompanyPresenter.new(@company)
  end
  
  test "should return default city state" do
    @company.city = nil
    assert_equal "City, State", CompanyPresenter.new(@company).present_city_state
  end

  test "should return city state" do
    @company.zip_code = '93004'
    @company.save
    assert_equal "Ventura, California", CompanyPresenter.new(@company).present_city_state
  end

  test "should return brand colour" do
    assert_equal "#28a745", @company_presenter.brand_colour
  end

end