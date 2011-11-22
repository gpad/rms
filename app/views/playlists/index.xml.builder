xml.playlists do |root|
  @playlists.each do |pl|
    root.playlist do |pl_tag|
      pl_tag.id(pl.id)
      pl_tag.name(pl.name)

      pl_tag.images do |imgs_tag|
        pl.images.each do |img|
          imgs_tag.image do |i| 
            i.id(img.id)
            i.name(img.name)
          end
        end
      end
    end
  end
end
