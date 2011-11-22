class Image < ActiveRecord::Base
  attr_accessor :picture
  validates :name, :uniqueness => true, :presence => true
  validates :picture, :presence => true

  has_many :playlist_items
  has_many :playlists, :through => :playlist_items
end
