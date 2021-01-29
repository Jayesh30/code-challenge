namespace :update_company do

  desc "update city and state for existing companies"
  task :update_city_state_from_zip => :environment do
    update_city_and_state_for_companies
  end

  def update_city_and_state_for_companies
    Company.find_each do |company|
      if company.zip_code and !(company.city and company.state)
        company.update_city_state_from_zip
        company.save!
      end
    end
  end
end