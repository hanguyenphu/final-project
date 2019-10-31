class CreateAbouts < ActiveRecord::Migration[6.0]
  def change
    create_table :abouts do |t|
      t.text :image
      t.string :header
      t.text :content

      t.timestamps
    end
  end
end
