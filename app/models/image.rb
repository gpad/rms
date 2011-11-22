class Image < ActiveRecord::Base
  attr_accessor :picture
  validates :name, :uniqueness => true, :presence => true
  validates :picture, :presence => true
end
