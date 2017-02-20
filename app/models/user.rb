class User < ActiveRecord::Base

  has_many :reviews

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 4 }
  validates :password_confirmation, presence: true

  has_secure_password

  def self.authenticate_with_credentials(email, password)
    user = User.where('lower(email) = ?', email.strip.downcase).first
    if user && user.authenticate(password)
      user
    else
      nil
    end
  end

end
