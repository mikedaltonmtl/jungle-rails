class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors.add(attribute, message: options[:message] || "is not an email")
    end
  end
end

class User < ActiveRecord::Base

  has_secure_password  

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true, email: true
  validates :password, presence: true
  validates :password_confirmation, presence: true

end