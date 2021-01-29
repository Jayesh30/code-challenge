class Company < ApplicationRecord
  include ActiveModel::Validations
  has_rich_text :description
  validates_with EmailValidator, :attributes=>[:email]

end
