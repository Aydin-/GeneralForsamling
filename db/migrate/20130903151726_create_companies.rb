class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :email
      t.string :company_name
      t.string :contact_name
      t.date :date
      t.string :time
      t.string :address

      t.timestamps
    end
  end
end
