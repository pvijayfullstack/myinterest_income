class CreateInvestments < ActiveRecord::Migration
  def self.up
    create_table :investments do |t|
      t.integer :customer_id
      t.integer :bank_id
      t.string :investment_name
      t.decimal :investment_amount
      t.float :investment_apy
      t.float :investment_years

      t.timestamps
    end
  end

  def self.down
    drop_table :investments
  end
end
