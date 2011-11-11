class ImagesController < ApplicationController
  def index
    img_root = File.join(Rails.root, 'public/images')
      @images = Dir.entries(img_root).select{|img| !File.directory?(img)}.collect do |img| 
        ImageInfo.new(img_root, img)
      end
  end
  
  def upload
    uploaded_io = params[:picture]
    if uploaded_io
      File.open(Rails.root.join('public', 'images', uploaded_io.original_filename), 'wb') do |file|
        file.write(uploaded_io.read)
      end
    end
    redirect_to '/'
  end


  def show
  end
end

class ImageInfo
  attr_reader :src
  attr_reader :name
  def initialize(path, name)
    @src = File.join(path, name)
    @name = name
  end
end


