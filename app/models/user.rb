class User < ActiveRecord::Base
  # Authentication
  has_secure_password
  
  # Scopes
  scope :worker, where(:report_payroll => true)
  
  # Attrs
  attr_accessible :email, :password, :password_confirmation
  
  # Relations
  has_many :weeks
  has_many :cc_batches
  
  # Validations
  validates_presence_of :email
  validates_uniqueness_of :email
  validates_confirmation_of :password
  validates_length_of :password, :minimum => 6
  
  # Methods
  def timesheet
    Week.timesheet_for(self)
  end
  
  def is_admin?
    self.is_admin
  end
  
  def generate_auth_key()
    update_attribute(:auth_key, User.newpass(16))
  end
  
  # Class Methods
  def self.authenticate(email, password)
    find_by_email(email).try(:authenticate, password)
  end
  
  def self.newpass( len )
    chars = ("A".."Z").to_a + ("0".."9").to_a
    newpass = ""
    1.upto(len) { |i| newpass << chars[rand(chars.size-1)] }
    return newpass
  end
  
end
