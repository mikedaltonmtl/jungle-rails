class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors.add(attribute, message: options[:message] || "is not an email")
    end
  end
end

class PasswordLengthValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A(?=.{8,})/x
      record.errors.add(attribute, message: options[:message] || "must contain 8 or more characters")
    end
  end
end


class User < ActiveRecord::Base

  before_save :downcase_email

  has_secure_password  

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }, email: true
  validates :password, presence: true, passwordLength: true
  validates :password_confirmation, presence: true


  def authenticate_with_credentials(email, password)
    user = User.find_by_email(email.strip.downcase)
    # If the user exists AND the password entered is correct return an instance of the user, else return nil
    user && user.authenticate(password) ? user : nil
  end

  private

  def downcase_email
    self.email = email.downcase
  end

end