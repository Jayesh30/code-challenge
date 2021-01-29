class CompaniesController < ApplicationController
  before_action :set_company, except: [:index, :create, :new]
  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

  def index
    @companies = Company.all
  end

  def new
    @company = Company.new
    @company.style_layout = StyleLayout.new
  end

  def show
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      redirect_to companies_path, notice: "#{@company.name} Created Successfully"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @company.update(company_params)
      redirect_to companies_path, notice: "Changes Saved"
    else
      render :edit
    end
  end

  def destroy
    name = @company.name
    if @company.destroy
      redirect_to companies_path, notice: "#{name} Successfully deleted"
    else
      Rails.logger.error "Error while deleting company: #{@company.id}, errors: #{@company.errors.full_messages}"
      redirect_to company_path(@company), alert: "Something went wrong. Please try again later OR Contact tech support"
    end
  end

  private

  def company_params
    params.require(:company).permit(
      :name,
      :legal_name,
      :description,
      :zip_code,
      :phone,
      :email,
      :owner_id,
      style_layout_attributes: [:brand_colour],
      services: []
    )
  end

  def set_company
    @company = Company.find(params[:id])
  end

  def handle_record_not_found
    redirect_to companies_path, alert: "Company Not Found"
  end
  
end
