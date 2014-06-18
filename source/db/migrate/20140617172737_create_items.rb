class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :body_part
      t.string :name
      t.integer :armor
      t.integer :durability
      t.integer :cost
      t.text :attributes

      t.timestamps
    end
  end
end
