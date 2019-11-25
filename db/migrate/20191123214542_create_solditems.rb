class CreateSolditems < ActiveRecord::Migration[6.0]
  def change
    create_table :solditems do |t|
      t.string :name
      t.text :description
      t.decimal :price, precision: 5, scale: 2
      t.integer :quantity
      t.references :category
      t.references :invoice

      t.timestamps
    end
  end
end
