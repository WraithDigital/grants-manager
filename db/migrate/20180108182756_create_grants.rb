class CreateGrants < ActiveRecord::Migration[5.1]
  def change
    create_table :grants do |t|
      t.references :agency,    null: false, foreign_key: true
      t.references :user,      null: false, foreign_key: true
      t.string     :title
      t.string     :url,       null: false
      t.string     :time_zone
      t.string     :sponsor
      t.string     :amount
      t.text       :residency
      t.text       :activity_location
      t.text       :body
      t.boolean    :dirty,     null: false, default: true
      t.integer    :remote_id

      t.timestamps
    end

    add_index :grants, :dirty
    add_index :grants, :created_at
    add_index :grants, :url, unique: true
    add_index :grants, :remote_id
  end
end
