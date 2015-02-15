class Car < ActiveRecord::Base
  acts_as_shareable_object [og: [app: [:id]]]

  def twitter_card
    "image"
  end

  def twitter_app_name_iphone
    "Bookagram"
  end

  def og_app_id
    "Some id"
  end

  def article_author
    "Jure Žove"
  end
end
