class College < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :classes
end
