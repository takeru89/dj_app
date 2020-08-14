class CreateWords < ActiveRecord::Migration[6.0]
  def change
    create_table :words do |t|
      t.references :user, null: false, foreign_key: true
      t.string     :kana, null: false
      t.string     :kanji
      t.string     :english, null: false
      t.integer    :pos_id, null: false
      t.text       :explanation, null: false
      t.timestamps
    end
  end
end
