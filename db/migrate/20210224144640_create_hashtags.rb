class CreateHashtags < ActiveRecord::Migration[6.1]
  def change
    create_table :hashtags do |t|
      t.string :label, null: false, comment: "タグの名前"

      t.timestamps
    end
    add_index :hashtags, :label, unique: true, comment: "タグに一意制約を設定"
  end
end
