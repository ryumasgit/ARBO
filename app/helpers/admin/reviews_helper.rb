module Public::ReviewsHelper
  def normalized_score(original_score)
    return normalized_score = ((original_score || 0) + 1) * 2.5
  end
end