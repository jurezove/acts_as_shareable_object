class AddMoreAttributesToCars < ActiveRecord::Migration
  def change
    add_column :cars, :company_twitter_handle, :string
    add_column :cars, :image, :string
    add_column :cars, :power, :string
    add_column :cars, :top_speed, :string
    add_column :cars, :acceleration, :string
  end
end
