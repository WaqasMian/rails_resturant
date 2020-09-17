class CreateMenusDishesJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_join_table :dishes, :menus do |t| 
      t.index :dish_id
      t.index :menu_id
    end
  end
end
