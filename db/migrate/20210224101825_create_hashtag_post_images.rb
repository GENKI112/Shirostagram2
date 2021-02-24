class CreateHashtagPostImages < ActiveRecord::Migration[6.1]
  def change
    create_table :hashtag_post_images do |t|
      t.references :posts, null: false, foreign_key: true
      t.references :hashtag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
