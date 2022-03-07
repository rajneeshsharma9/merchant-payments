class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.string :uuid
      t.string :customer_email
      t.string :customer_phone
      t.decimal :amount, precision: 8, scale: 2, default: 0.0
      t.integer :status, null: false
      t.string :type
      t.timestamps
      t.references :transaction
      t.references :merchant

      t.index :uuid
    end
  end
end
