class CreateMerchants < ActiveRecord::Migration[6.1]
  def change
    create_table :merchants do |t|
      t.string :name
      t.text :description
      t.boolean :active, default: false, null: false
      t.string :email
      t.decimal :total_transaction_sum, precision: 8, scale: 2, default: 0.0
      t.boolean :admin, default: false, null: false

      t.timestamps
    end
  end
end
