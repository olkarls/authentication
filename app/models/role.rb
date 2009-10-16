class Role < ActiveRecord::Base
  has_many :users
  validates_presence_of :name, :level
  validates_uniqueness_of :name
end