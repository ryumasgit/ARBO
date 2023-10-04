module Public::ExhibitionsHelper
  
  def review_score_average(review)
    original_score = review.average(:score).round(1)
    return normalized_score = ((original_score || 0) + 1) * 2.5
  end
end
