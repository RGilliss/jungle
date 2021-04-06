class User < ActiveRecord::Base
  has_secure_password
  def authenticate_with_credentials (email, password)
    
    user = User.find_by_email(email.to_s.strip.downcase)
    if user && user.authenticate(password)
      user
    else
      nil
    end
  end
  def email=(val)
    super(val.to_s.strip)
  end
  validates :name, presence: true
  validates :password, presence: true, :length => 3..50 
  validates :password_confirmation, presence: true
  validates :email, presence: true
  validates_uniqueness_of :email, :case_sensitive => false

end
