class CompanyPresenter
  def initialize(company)
    @company = company
  end
  def present_city_state
    if @company.state && @company.city
      "#{@company.city}, #{@company.state}"
    else
      "City, State"
    end
  end

  def services
    @company.services.reject(&:blank?)
  end

end
