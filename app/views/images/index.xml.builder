xml.images do |root|
  @images.each do |img|
    xml.image do |i| 
      #i.id(img.id)
      i.name(img.name)
    end
  end
end
