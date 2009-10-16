class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation
  
  validates_presence_of   :email, :password
  validates_uniqueness_of :email, :case_insensitive => true
  
  after_create :add_default_role
  belongs_to :role
  acts_as_authentic
  
  def deliver_password_reset_instructions!  
    reset_perishable_token!  
    Notifier.deliver_password_reset_instructions(self)  
  end
  
  def add_default_role
    if self.role_id.blank?
      self.role_id = 3
      self.save
    end
  end
end
