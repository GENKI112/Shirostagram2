class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|

      t.string :caption
      t.text :input_hash
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
  end
end
