class CreateHospital < ActiveRecord::Migration
  def change
    create_table :hospitals do |t|
      t.string :hospital_name
      t.string :address
      t.string :city
      t.string :state
      t.integer :zip_code
      t.string :phone
      t.string :measure
      t.float :score
    end
  end
end
