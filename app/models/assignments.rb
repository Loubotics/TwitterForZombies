class Assignments < ActiveRecord::Base
  attr_accessible :role_id, :zombie_id
  belongs_to :zombie, :role
end
