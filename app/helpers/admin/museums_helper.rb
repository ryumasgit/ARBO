module Admin::MuseumsHelper

  def museum_is_active_display(museum)
    if museum.is_active == true
      "公開中"
    else
      "非公開中"
    end
  end
end