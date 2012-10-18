class ClassEntry < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :user, :class_list
end
