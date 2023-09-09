module Admin::ExhibitionsHelper
  
  def artist_is_active_display(artist)
    if artist.is_active == true
      "公開中"
    else
      "非公開中"
    end
  end
end
