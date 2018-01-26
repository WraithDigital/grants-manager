class CreateAgencies < ActiveRecord::Migration[5.1]
  def change
    create_table :agencies do |t|
      t.string :name,      null: false
      t.string :shortname, null: false

      t.timestamps
    end

    add_index :agencies, :shortname, unique: true
  end
end
