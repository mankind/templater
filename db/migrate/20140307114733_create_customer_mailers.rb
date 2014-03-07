class CreateCustomerMailers < ActiveRecord::Migration
  def change
    create_table :customer_mailers do |t|
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
