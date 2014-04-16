class CreateWorks < ActiveRecord::Migration
  def change
    create_table :works do |t|
      t.string :name, null: false
      t.integer :user_id

      t.timestamps
    end
  end
end
