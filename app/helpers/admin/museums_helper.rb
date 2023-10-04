module Admin::MuseumsHelper

  def museum_is_active_display(museum)
    if museum.is_active == true
      "公開中"
    else
      "非公開中"
    end
  end

  def review_score_average(review)
    original_score = review.average(:score).round(1)
    return normalized_score = ((original_score || 0) + 1) * 2.5
  end
end