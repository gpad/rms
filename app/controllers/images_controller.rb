class ImageInfo
	attr_reader :src
	attr_reader :name
	def initialize(path, name)
		@src = File.join(path, name)
		@name = name
	end
end

class ImagesController < ApplicationController
	def index
		img_root = File.join(Rails.root, 'public/images')
		@images = Dir.entries(img_root).select{|img| !File.directory?(img)}.collect do |img| 
			ImageInfo.new(img_root, img)
		end
	end
end
