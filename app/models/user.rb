class User < ActiveRecord::Base
  #Convert emails to lowercase before saving in the database
  before_save { email.downcase! }

  #Name Validations
  validates :name, presence: true, length: { maximum: 50 }

  #Email Validations
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }

  #Secure Password
  has_secure_password
  #Password Validations
  validates :password, length: { minimum: 6 }




end


