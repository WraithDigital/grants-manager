class CreateDeadlines < ActiveRecord::Migration[5.1]
  def change
    create_table :deadlines do |t|
      t.references :grant, null: false, foreign_key: true
      t.datetime   :date
      t.string     :item_due
      t.string     :notes, null: false

      t.timestamps
    end

    add_index :deadlines, :date
    add_index :deadlines, :item_due
  end
end
