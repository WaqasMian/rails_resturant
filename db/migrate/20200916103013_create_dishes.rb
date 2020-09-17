class CreateDishes < ActiveRecord::Migration[6.0]
  def change
    create_table :dishes do |t|
      t.string :name
      t.string :cateogry
      t.integer :visits
      t.integer :price

      t.timestamps
    end
  end
end
