class Company < ApplicationRecord
  include ActiveModel::Validations
  has_one :style_layout, dependent: :destroy
  accepts_nested_attributes_for :style_layout
  has_rich_text :description
  validates_with EmailValidator, :attributes=>[:email]
  before_save :update_city_state_from_zip, if: :zip_code_changed?

  delegate :brand_colour, to: :style_layout, allow_nil: true

  def update_city_state_from_zip
    return if zip_code.nil?

    address = ZipCodes.identify(zip_code.to_s) || {}
    self.state = address[:state_name]
    self.city = address[:city]
  end

end
