require 'test_helper'

class ViewHelpersTest < ActionDispatch::IntegrationTest
  fixtures :cars

  test "car make and model on detail page" do
    car = cars(:pagani)
    get car_path(car)
    assert_select "h1", "#{car.make} #{car.model}"
  end

  test "twitter card type in head" do
    car = cars(:pagani)

    Car.class_eval do
      def twitter_card
        "summary"
      end
    end

    get car_path(car)

    assert_select "meta[name=\"twitter:card\"]" do |tags|
      assert_select "[content=?]", car.twitter_card
    end
  end

  test "twitter image card nested properties" do
    car = cars(:pagani)

    Car.class_eval do
      def twitter_card
        "image"
      end

      def twitter_image_src
        image
      end

      def twitter_image_width
        "812"
      end

      def twitter_image_height
        "475"
      end
    end

    get car_path(car)

    assert_select "meta[name=\"twitter:card\"]" do |tags|
      assert_select "[content=?]", car.twitter_card
    end

    assert_select "meta[name=\"twitter:image:src\"]" do |tags|
      assert_select "[content=?]", car.twitter_image_src
    end

    assert_select "meta[name=\"twitter:image:width\"]" do |tags|
      assert_select "[content=?]", car.twitter_image_width
    end

    assert_select "meta[name=\"twitter:image:height\"]" do |tags|
      assert_select "[content=?]", car.twitter_image_height
    end
  end

end
