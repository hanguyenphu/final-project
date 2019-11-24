class CreateInvoices < ActiveRecord::Migration[6.0]
  def change
    create_table :invoices do |t|
      t.string :status
      t.decimal :total, precision: 5, scale: 2
      t.string :province
      t.decimal :gst
      t.decimal :pst
      t.decimal :hst
      t.string :user_id
      t.string :payment_id

      t.timestamps
    end
  end
end
