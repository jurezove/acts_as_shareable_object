require 'test_helper'

class ViewHelpersTest < ActionDispatch::IntegrationTest
  fixtures :all

  test "car make and model on detail page" do
    car = cars(:pagani)
    get car_path(car)
    assert_select "h1", "#{car.make} #{car.model}"
  end

  test "twitter card type in head" do
    car = cars(:pagani)

    Car.any_instance.stubs(:twitter_card).returns("summary")

    get car_path(car)

    assert_select "meta[name=\"twitter:card\"]" do |tags|
      assert_select "[content=?]", car.twitter_card
    end
  end

  test "twitter image card nested properties" do
    car = cars(:pagani)

    Car.any_instance.stubs(:twitter_card).returns("image")
    Car.any_instance.stubs(:twitter_image_src).returns(car.image)
    Car.any_instance.stubs(:twitter_image_width).returns("812")
    Car.any_instance.stubs(:twitter_image_height).returns("475")

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

  test "custom shareable tags" do
    car = cars(:pagani)

    Car.class_eval do
      acts_as_shareable_object og: [:custom_property, nested: [:egg]]
    end

    Car.any_instance.stubs(:og_custom_property).returns("og custom property")
    Car.any_instance.stubs(:og_nested_egg).returns("nested egg")

    get car_path(car)

    assert_select "meta[name=\"og:custom_property\"]" do |tags|
      assert_select "[content=?]", car.og_custom_property
    end

    assert_select "meta[name=\"og:nested:egg\"]" do |tags|
      assert_select "[content=?]", car.og_nested_egg
    end
  end

end
