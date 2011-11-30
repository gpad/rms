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
    @playlist = Playlist.new(params[:playlist])
    respond_to do |format|
      if @playlist.save
        format.html { redirect_to(@playlist, :notice => 'Playlist was successfully created.') }
        format.xml  { render :xml => @playlist, :status => :created, :location => @playlist}
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @playlist.errors, :status => :unprocessable_entity }
      end
    end
  end

  def edit
    @playlist = Playlist.find(params[:id])
  end

  def create_images par_images
    logger.debug par_images.class
    return par_images.collect do |par_img| 
      img = Image.find(par_img['id'])
    end
  end

  def update
    @playlist = Playlist.find(params[:id])
    respond_to do |format|
      @playlist.name = params[:playlist][:name]
      @playlist.images = create_images(params[:playlist][:images])
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

  def destroy
    @playlist = Playlist.find(params[:id])
    @playlist.destroy
    respond_to do |format|
      format.html { redirect_to(playlists_url) }
      format.xml  { head :ok }
    end
  end
end
