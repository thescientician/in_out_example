class Team < ActiveRecord::Base
  has_many :users
  default_scope order('name ASC')
  
  attr_accessible :name
  validates :name, presence:true
end
