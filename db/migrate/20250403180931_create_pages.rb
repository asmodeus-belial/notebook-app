class CreatePages < ActiveRecord::Migration[7.2]
  def change
    create_table :pages do |t|
      t.string :title
      t.text :context
      t.string :emoji_category
      t.references :notebook, null: false, foreign_key: true

      t.timestamps
    end
  end
end
