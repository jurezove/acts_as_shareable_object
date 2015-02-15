require 'test_helper'

class ActsAsShareableObjectTest < ActiveSupport::TestCase
  fixtures :cars

  test "truth" do
    assert_kind_of Module, ActsAsShareableObject
  end

  test "twitter summary card type" do
    car = cars(:pagani)
    
    def car.twitter_card
      "summary"
    end

    assert_equal car.social_meta_properties[:twitter][:card], "summary"
  end

  test "twitter summary card image" do
    car = cars(:pagani)

    class << car
      alias_attribute :twitter_image, :image
    end

    assert_equal car.social_meta_properties[:twitter][:image], car.image
  end

  test "twitter card site" do
    car = cars(:pagani)

    class << car
      alias_attribute :twitter_site, :company_twitter_handle
    end

    assert_equal car.social_meta_properties[:twitter][:site], car.company_twitter_handle
  end

  # Twitter Photo Card

  test "twitter photo card image src" do
    car = cars(:pagani)

    class << car
      alias_attribute :twitter_image_src, :image
    end

    assert_equal car.social_meta_properties[:twitter][:image][:src], car.image

  end

  test "twitter photo card image details" do
    car = cars(:pagani)

    class << car
      alias_attribute :twitter_image_src, :image
      def twitter_image_width
        "812"
      end

      def twitter_image_height
        "475"
      end
    end

    assert_equal car.social_meta_properties[:twitter][:image][:src], car.image
    assert_equal car.social_meta_properties[:twitter][:image][:width], car.twitter_image_width
    assert_equal car.social_meta_properties[:twitter][:image][:height], car.twitter_image_height
  end

end
