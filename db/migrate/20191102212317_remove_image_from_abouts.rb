class RemoveImageFromAbouts < ActiveRecord::Migration[6.0]
  def change

    remove_column :abouts, :image, :text
  end
end
