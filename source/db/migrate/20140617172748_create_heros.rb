class CreateHeros < ActiveRecord::Migration
  def change
    create_table :heros do |t|
      t.integer :blizz_id
      t.string :name
      t.integer :level
      t.integer :gender
      t.string :hero_class
      t.belongs_to :user
      # t.string :skills
      # t.string :items
    end
  end
end
