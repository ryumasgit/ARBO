module Admin::ArtistsHelper
  
  def exhibition_is_active_display(exhibition)
    if exhibition.is_active == true
      "公開中"
    else
      "非公開中"
    end
  end
end
