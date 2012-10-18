class Class < ActiveRecord::Base
  belongs_to :college
  attr_accessible :class_name, :course_id
end
