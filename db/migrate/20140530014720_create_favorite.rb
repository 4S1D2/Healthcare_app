class CreateFavorite < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.references :user_id
      t.references :hospital_id
    end
  end
end
