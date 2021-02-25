class CreatePostTaggings < ActiveRecord::Migration[6.1]
  def change
    create_table :post_taggings do |t|
      t.references :post, foreign_key: { on_delete: :cascade }, comment: "Postテーブルとの関連付け"
      t.references :hashtag, foreign_key: true, comment: "Hashtagテーブルとの関連付け"

      t.timestamps
    end
    add_index :post_taggings, [:post_id, :hashtag_id], unique: true, comment: "postに対して同じtagを複数つけられないよう設定"
  end
end
