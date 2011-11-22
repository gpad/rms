class PlaylistItem < ActiveRecord::Base
  belongs_to :image
  belongs_to :playlist
end
