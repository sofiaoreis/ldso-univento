class CreateCategoryTags < ActiveRecord::Migration
  def change
    create_table :category_tags do |t|

      t.timestamps null: false
    end
  end
end
