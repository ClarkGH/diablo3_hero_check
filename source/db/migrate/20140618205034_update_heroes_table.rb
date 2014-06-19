class UpdateHeroesTable < ActiveRecord::Migration
  def change
      add_column :heros, :top_item, :string
      add_column :heros, :top_stat, :string
      add_column :heros, :item_url, :string
      add_column :heros, :stat_title, :string
  end
end
