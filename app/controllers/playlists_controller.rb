class PlaylistsController < ApplicationController
  def index
    @playlists = Playlist.all
    #respond_to do |format|
    #  format.html
    #  format.xml { render :xml => @playlists }
    #end
  end

  def new
    @playlist = Playlist.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @playlist }
    end
  end

  def show
    @playlist = Playlist.find(params[:id])
  end

  def create
    #@playlist = Playlist.new(params[:playlist])
    @playlist = Playlist.new()
    @playlist.name = params[:playlist][:name]
    @playlist.playlist_items << create_images([]).collect{|i| PlaylistItem.new({:image_id => i.id})}
    respond_to do |format|
      if @playlist.save
        @playlist = @playlist.reload
        logger.debug "playlist --> @playlist"
        format.html { redirect_to(@playlist, :notice => 'Playlist was successfully created.') }
        format.xml  { render :template => 'playlists/show', :status => :created, :location => @playlist}
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @playlist.errors, :status => :unprocessable_entity }
      end
    end
  end

  def edit
    @playlist = Playlist.find(params[:id])
  end

  def create_images def_images
    if !params[:playlist].key? :images
      return def_images
    end

    par_images = params[:playlist][:images]
    if (par_images.nil?)
      return []
    end

    if !par_images.is_a? Array
      par_images = par_images['image']
    end
    if (par_images.nil?)
      return []
    end
    if par_images.is_a? Array
      return par_images.collect do |par_img|
        my_id = par_img['id']
        img = Image.find(my_id)
      end
    elsif
      img = Image.find(par_images['id'])
      return [img]
    end
  end

  def update
    @playlist = Playlist.find(params[:id])
    respond_to do |format|
      @playlist.name = params[:playlist][:name]
      @playlist.images = create_images(@playlist.images)
      if @playlist.save 
      #if @playlist.update_attributes(params[:playlist])
        format.html { redirect_to(@playlist, :notice => 'Playlist was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @playlist.errors, :status => :unprocessable_entity }
      end
    end
  end

  def reset
    Playlist.all.each {|pl| pl.destroy }
    respond_to do |format|
      format.html { redirect_to(playlists_url) }
      format.xml  { head :ok }
    end
  end

  def destroy
    @playlist = Playlist.find(params[:id])
    @playlist.destroy
    respond_to do |format|
      format.html { redirect_to(playlists_url) }
      format.xml  { head :ok }
    end
  end
end
