class Playlist < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true

  has_many :playlist_items
  has_many :images, :through => :playlist_items
  accepts_nested_attributes_for :images, :allow_destroy => true
end
