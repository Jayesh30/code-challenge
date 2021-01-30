require "test_helper"

class CompanyTest < ActiveSupport::TestCase
  setup do
    @company = companies(:hometown_painting)
  end

  test "should save without changing email" do
    assert @company.save
  end

  test "should not save when changing email and not @getmainstreet.com domain" do
    @company.update(email: "john.doe@example.com")
    assert_equal [" domain should be test.com"], @company.errors[:email]
  end

  test "should save without email" do
    assert @company.update(email: nil)
    assert @company.validate
  end

end