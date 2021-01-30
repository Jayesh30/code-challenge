class EmailValidator < ActiveModel::Validator
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  EMAIL_DOMAIN = Settings.email_domain

  def validate(record)
    if record.email.present?
      email = record.email.downcase
      record.errors.add :email, " is not in valid format" unless VALID_EMAIL_REGEX =~ email
      record.errors.add :email, " domain should be #{EMAIL_DOMAIN}" unless email.end_with?(EMAIL_DOMAIN)
    end
  end
end