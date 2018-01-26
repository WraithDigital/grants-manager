class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.references :grant,  null: false, foreign_key: true
      t.references :user,   null: false, foreign_key: true
      t.string     :status, null: false
      t.text       :submitter_notes
      t.text       :reviewer_notes

      t.timestamps
    end

    add_index :reviews, :status
    add_index :reviews, :created_at
  end
end
