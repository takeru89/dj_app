class RenamePosColumnToWords < ActiveRecord::Migration[6.0]
  def change
    rename_column :words, :pos_id, :word_class_id
  end
end
