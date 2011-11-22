xml.playlist do |root|
  root.id(@playlist.id)
  root.name(@playlist.name)

  xml.images do |root|
    @playlist.images.each do |img|
      xml.image do |i| 
        i.id(img.id)
        i.name(img.name)
      end
    end
  end


end

