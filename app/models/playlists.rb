class Playlists < ActiveRecord::Base
  has_many: images
  validate name, uniqueness => true
end
