class User < ActiveRecord::Base
  #Convert emails to lowercase before saving in the database
  before_save { email.downcase! }
  before_create :create_remember_token

  has_many :microposts, dependent: :destroy
  #Name Validations
  validates :name, presence: true, length: {maximum: 50}

  #Email Validations
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX},
            uniqueness: {case_sensitive: false}

  #Secure Password
  has_secure_password
  #Password Validations                 db
  validates :password, length: {minimum: 6}

  def feed
    # This is preliminary. See "Following users" for the full implementation.
    Micropost.where("user_id = ?", id)
  end

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end
end