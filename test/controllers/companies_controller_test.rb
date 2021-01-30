require "test_helper"
require "application_system_test_case"

class CompaniesControllerTest < ApplicationSystemTestCase

  def setup
    @company = companies(:hometown_painting)
  end

  test "Index" do
    visit companies_path

    assert_text "Companies"
    assert_text "Hometown Painting"
    assert_text "Wolf Painting"
  end

  test "Show" do
    visit company_path(@company)

    assert_text @company.name
    assert_text @company.phone
    assert_text @company.email
    assert_text "City, State"
  end

  test "Update" do
    visit edit_company_path(@company)

    within("form#edit_company_#{@company.id}") do
      fill_in('company_email', with: 'new_test_company@getmainstreet.com', fill_options: { clear: :backspace })
      click_button "Update Company"
    end

    assert_text "Email must end with test.com"

    visit edit_company_path(@company)

    within("form#edit_company_#{@company.id}") do
      fill_in('company_name', with: 'Updated Test Company', fill_options: { clear: :backspace })
      fill_in('company_zip_code', with: '93009', fill_options: { clear: :backspace })
      fill_in('company_email', with: 'new_test_company@test.com', fill_options: { clear: :backspace })
      click_button "Update Company"
    end

    assert_text "Changes Saved"

    @company.reload
    assert_equal "Updated Test Company", @company.name
    assert_equal "93009", @company.zip_code
    assert_equal  "Ventura", @company.city
    assert_equal  "California", @company.state
    assert_equal  "#000000", @company.brand_colour

  end

  test "Create" do
    visit new_company_path

    within("form#new_company") do
      fill_in("company_name", with: "New Test Company")
      fill_in("company_zip_code", with: "28173")
      fill_in("company_phone", with: "5553335555")
      fill_in("company_email", with: "new_test_company@test.com")
      click_button "Create Company"
    end

    assert_text "New Test Company Created Successfully"

    last_company = Company.last
    assert_equal "New Test Company", last_company.name
    assert_equal "28173", last_company.zip_code
    assert_equal  "Waxhaw", last_company.city
    assert_equal  "North Carolina", last_company.state
    assert_equal  "#000000", last_company.brand_colour
  end

  test 'Set city and state via zip code' do
    visit edit_company_path(@company)
    within("form#edit_company_#{@company.id}") do
      fill_in('company_zip_code', with: "28173", fill_options: {clear: :backspace})
      click_button 'Update Company'
      @company.reload
      assert_equal "Waxhaw", @company.city
      assert_equal "North Carolina", @company.state
    end
  end

  test "Destroy" do
    visit company_path(@company)

    assert_difference("Company.count", -1) do
      accept_alert do
        click_link "Delete"
      end

      assert_text "Hometown Painting Successfully deleted"
      assert_equal companies_path, current_path
    end
  end

end
