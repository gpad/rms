class ImagesController < ApplicationController
  # GET /images
  # GET /images.xml
  def index
    @images = Image.all
  end

  # GET /images/1
  # GET /images/1.xml
  def show
    @image = Image.find(params[:id])
  end

  # GET /images/new
  # GET /images/new.xml
  def new
    @image = Image.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @image }
    end
  end

  # GET /images/1/edit
  def edit
    @image = Image.find(params[:id])
  end

  # POST /images
  # POST /images.xml
  def create
    @image = Image.new(params[:image])


    # logger.debug "imagine.name = '#{@image.name}'"
    # logger.debug "params = #{params}"

    respond_to do |format|
      if @image.save
        save_picture @image.name, @image.picture
        format.html { redirect_to(@image, :notice => 'Image was successfully created.') }
        format.xml  { render :xml => @image, :status => :created, :location => @image }
      else
        logger.debug "save fails #{@image.errors}"
        format.html { render :action => "new" }
        format.xml  { render :xml => @image.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /images/1
  # PUT /images/1.xml
  def update
    @image = Image.find(params[:id])

    respond_to do |format|
      if @image.update_attributes(params[:image])
        save_picture @image.name, @image.picture
        format.html { redirect_to(@image, :notice => 'Image was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @image.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /images/1
  # DELETE /images/1.xml
  def destroy
    @image = Image.find(params[:id])
    begin
      File.delete(Rails.root.join('public', 'images', @image.name))
    rescue
      logger.warning "Unable to delete file @{image.name}"
    end
    @image.destroy

    respond_to do |format|
      format.html { redirect_to(images_url) }
      format.xml  { head :ok }
    end
  end

  private
  def save_picture filename, uploaded_io
    if uploaded_io
      File.open(Rails.root.join('public', 'images', filename), 'wb') do |file|
        file.write(uploaded_io.read)
      end
    end
  end
end
