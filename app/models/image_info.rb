class ImageInfo < ActiveRecord::Base
  attr_reader :src
  attr_reader :name
  attr_reader :id
  attr_reader :model_name
  def initialize(path, name)
    @src = File.join(path, name)
    @name = name
    @id = 44
  end
end


