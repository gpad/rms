class PlaylistsController < ApplicationController
  def index
    Playlist.all
  end
end
